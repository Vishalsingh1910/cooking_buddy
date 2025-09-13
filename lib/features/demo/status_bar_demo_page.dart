import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/status_bar_utils.dart';
import '../../core/widgets/custom_app_bar.dart';

class StatusBarDemoPage extends ConsumerWidget {
  const StatusBarDemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar.light(
        title: 'Status Bar Demo',
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Status Bar Styling Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Test different status bar styles',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildDemoButton(
                context,
                'Light Status Bar',
                'Dark icons on light background',
                AppColors.background,
                AppColors.textPrimary,
                () => StatusBarUtils.setLightStatusBar(),
              ),
              const SizedBox(height: 16),
              _buildDemoButton(
                context,
                'Dark Status Bar',
                'Light icons on dark background',
                AppColors.textPrimary,
                Colors.white,
                () => StatusBarUtils.setDarkStatusBar(),
              ),
              const SizedBox(height: 16),
              _buildDemoButton(
                context,
                'Primary Status Bar',
                'Light icons on primary background',
                AppColors.primary,
                Colors.white,
                () => StatusBarUtils.setPrimaryStatusBar(),
              ),
              const SizedBox(height: 16),
              _buildDemoButton(
                context,
                'Transparent Status Bar',
                'For overlay screens',
                Colors.transparent,
                AppColors.textPrimary,
                () => StatusBarUtils.setTransparentStatusBar(),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => StatusBarUtils.resetToDefault(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Reset to Default',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Look at the status bar (top of screen) to see the changes. The status bar icons will change color based on the selected style.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDemoButton(
    BuildContext context,
    String title,
    String subtitle,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor == Colors.transparent
            ? AppColors.surface
            : backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: backgroundColor == Colors.transparent
            ? Border.all(color: AppColors.textLight.withValues(alpha: 0.3))
            : null,
        boxShadow: backgroundColor != Colors.transparent
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: backgroundColor == AppColors.textPrimary
                        ? Colors.white.withValues(alpha: 0.2)
                        : backgroundColor == AppColors.primary
                            ? Colors.white.withValues(alpha: 0.2)
                            : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.phone_android,
                    color: backgroundColor == AppColors.textPrimary
                        ? Colors.white
                        : backgroundColor == AppColors.primary
                            ? Colors.white
                            : AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.touch_app,
                  color: textColor.withValues(alpha: 0.5),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
