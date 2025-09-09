import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class ContextBanner extends StatelessWidget {
  const ContextBanner({super.key});

  String _getContextMessage() {
    final hour = DateTime.now().hour;
    final month = DateTime.now().month;

    // Time-based suggestions
    if (hour >= 6 && hour < 10) {
      return 'Perfect breakfast ideas to start your day! ☀️';
    } else if (hour >= 17 && hour < 20) {
      return 'Quick dinner ideas for busy evening 🌆';
    }

    // Seasonal suggestions
    if (month >= 6 && month <= 8) {
      return 'Fresh summer ingredients available 🌿';
    } else if (month >= 12 || month <= 2) {
      return 'Perfect soup weather today! 🍲';
    } else if (month >= 3 && month <= 5) {
      return 'Spring vegetables are in season 🌱';
    } else {
      return 'Cozy autumn recipes to warm you up 🍂';
    }
  }

  IconData _getContextIcon() {
    final hour = DateTime.now().hour;
    final month = DateTime.now().month;

    if (hour >= 6 && hour < 10) {
      return Icons.wb_sunny;
    } else if (hour >= 17 && hour < 20) {
      return Icons.dinner_dining;
    }

    if (month >= 6 && month <= 8) {
      return Icons.local_florist;
    } else if (month >= 12 || month <= 2) {
      return Icons.soup_kitchen;
    } else if (month >= 3 && month <= 5) {
      return Icons.eco;
    } else {
      return Icons.park;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondary.withValues(alpha: 0.1),
            AppColors.primary.withValues(alpha: 0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getContextIcon(),
              color: AppColors.secondary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _getContextMessage(),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
