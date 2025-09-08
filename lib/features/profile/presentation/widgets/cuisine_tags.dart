import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class CuisineTags extends StatelessWidget {
  const CuisineTags({super.key});

  @override
  Widget build(BuildContext context) {
    final cuisines = [
      {'name': 'Mediterranean', 'color': AppColors.primary},
      {'name': 'Asian', 'color': AppColors.secondary},
      {'name': 'Italian', 'color': AppColors.warning},
      {'name': 'Mexican', 'color': AppColors.success},
      {'name': 'Indian', 'color': AppColors.error},
      {'name': 'French', 'color': AppColors.primary},
    ];

    return Wrap(
      spacing: AppConstants.paddingSmall,
      runSpacing: AppConstants.paddingSmall,
      children: cuisines
          .map((cuisine) => _buildCuisineTag(
                cuisine['name'] as String,
                cuisine['color'] as Color,
              ))
          .toList(),
    );
  }

  Widget _buildCuisineTag(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: AppConstants.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Text(
            name,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
