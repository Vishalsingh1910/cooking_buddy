import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';

class StatusBarUtils {
  /// Sets status bar style for light backgrounds (most of the app)
  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.cardBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Sets status bar style for dark backgrounds (splash, some overlays)
  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.textPrimary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// Sets status bar style for primary colored backgrounds (app bars)
  static void setPrimaryStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.cardBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Sets status bar style for transparent overlays
  static void setTransparentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// Resets to default app status bar (light theme)
  static void resetToDefault() {
    setLightStatusBar();
  }
}
