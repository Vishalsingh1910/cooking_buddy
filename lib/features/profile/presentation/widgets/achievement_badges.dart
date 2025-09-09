import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class AchievementBadges extends StatelessWidget {
  const AchievementBadges({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {
        'title': 'First Recipe',
        'description': 'Posted your first recipe',
        'icon': Icons.restaurant_menu,
        'color': AppColors.success,
        'earned': true,
      },
      {
        'title': 'Popular Chef',
        'description': '100+ recipe likes',
        'icon': Icons.favorite,
        'color': AppColors.like,
        'earned': true,
      },
      {
        'title': 'Community Helper',
        'description': 'Helped 50+ people',
        'icon': Icons.help,
        'color': AppColors.secondary,
        'earned': true,
      },
      {
        'title': 'Master Chef',
        'description': '50+ recipes shared',
        'icon': Icons.star,
        'color': AppColors.warning,
        'earned': false,
      },
      {
        'title': 'Social Butterfly',
        'description': '1000+ followers',
        'icon': Icons.people,
        'color': AppColors.primary,
        'earned': false,
      },
      {
        'title': 'Recipe Collector',
        'description': 'Saved 100+ recipes',
        'icon': Icons.bookmark,
        'color': AppColors.save,
        'earned': true,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppConstants.paddingMedium,
        mainAxisSpacing: AppConstants.paddingMedium,
        childAspectRatio: 0.8,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final achievement = achievements[index];
        return _buildAchievementBadge(
          title: achievement['title'] as String,
          description: achievement['description'] as String,
          icon: achievement['icon'] as IconData,
          color: achievement['color'] as Color,
          earned: achievement['earned'] as bool,
        );
      },
    );
  }

  Widget _buildAchievementBadge({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool earned,
  }) {
    return GestureDetector(
      onTap: () {
        // Show achievement details
      },
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: earned ? color.withOpacity(0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: earned
                ? color.withOpacity(0.3)
                : AppColors.textLight.withOpacity(0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: earned ? color : AppColors.textLight,
                borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: earned ? AppColors.textPrimary : AppColors.textLight,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              description,
              style: TextStyle(
                fontSize: 10,
                color: earned ? AppColors.textSecondary : AppColors.textLight,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
