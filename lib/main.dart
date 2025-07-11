import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:math' as math;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceAnalyzerScreen(cameras: cameras),
    );
  }
}

class FaceAnalyzerScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const FaceAnalyzerScreen({required this.cameras});

  @override
  _FaceAnalyzerScreenState createState() => _FaceAnalyzerScreenState();
}

class _FaceAnalyzerScreenState extends State<FaceAnalyzerScreen> {
  late CameraController _controller;
  bool _isDetecting = false;
  String _faceCondition = "Scanning...";
  double _brightnessLevel = 0.0;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.fast,
    ),
  );

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(
      widget.cameras[0], // Using first camera (usually front)
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    if (!mounted) return;

    _controller.startImageStream(_processCameraImage);
    setState(() {});
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isDetecting) return;
    _isDetecting = true;

    // Convert camera image to format suitable for ML Kit
    final inputImage = _convertCameraImage(image);
    final faces = await _faceDetector.processImage(inputImage);

    // Calculate brightness from image
    _calculateBrightness(image);

    String condition = "No face detected";
    if (faces.isNotEmpty) {
      final face = faces.first;
      condition = _analyzeFace(face);
    }

    setState(() {
      _faceCondition = condition;
    });

    _isDetecting = false;
  }

  InputImage _convertCameraImage(CameraImage image) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation90deg,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes[0].bytesPerRow,
      ),
    );
  }

  void _calculateBrightness(CameraImage image) {
    // Simple brightness calculation from YUV data
    final yPlane = image.planes[0].bytes;
    double sum = 0;
    for (int i = 0; i < yPlane.length; i += 100) {
      // Sample every 100th pixel
      sum += yPlane[i];
    }
    _brightnessLevel = sum / (yPlane.length / 100) / 255;

    // Adjust camera exposure based on brightness
    if (_brightnessLevel < 0.3) {
      _controller.setExposureOffset(0.5);
    } else if (_brightnessLevel > 0.7) {
      _controller.setExposureOffset(-0.5);
    } else {
      _controller.setExposureOffset(0.0);
    }
  }

  String _analyzeFace(Face face) {
    String condition = "";

    // Check smile probability for happiness
    if (face.smilingProbability != null) {
      if (face.smilingProbability! > 0.7) {
        condition += "Happy ";
      } else if (face.smilingProbability! < 0.3) {
        condition += "Sad ";
      }
    }

    // Check eye open probability for tiredness
    if (face.leftEyeOpenProbability != null &&
        face.rightEyeOpenProbability != null) {
      double avgEyeOpen =
          (face.leftEyeOpenProbability! + face.rightEyeOpenProbability!) / 2;
      if (avgEyeOpen < 0.4) {
        condition += "Tired ";
      }
    }

    // Stress detection (simplified - could be enhanced with more features)
    if (face.headEulerAngleY != null && face.headEulerAngleZ != null) {
      if (math.cos(face.headEulerAngleY!) > 20 ||
          math.cos(face.headEulerAngleZ!) > 20) {
        condition += "Stressed ";
      }
    }

    // Lighting condition
    if (_brightnessLevel < 0.3) {
      condition += "(Dim Light)";
    } else if (_brightnessLevel > 0.7) {
      condition += "(Bright Light)";
    }

    return condition.isEmpty ? "Neutral" : condition.trim();
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.black54,
              child: Column(
                children: [
                  Text(
                    "Face Condition: $_faceCondition",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Brightness: ${(_brightnessLevel * 100).toStringAsFixed(1)}%",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
