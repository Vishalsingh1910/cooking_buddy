import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/status_bar_utils.dart';
import 'features/splash/presentation/pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set default status bar style
  StatusBarUtils.setLightStatusBar();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookingBuddy',
      theme: AppTheme.lightTheme,
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
