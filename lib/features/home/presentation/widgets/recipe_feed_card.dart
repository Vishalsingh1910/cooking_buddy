import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class RecipeFeedCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String cookingTime;
  final String difficulty;
  final String chefName;
  final String chefAvatar;
  final int likes;
  final bool isLiked;
  final bool isSaved;

  const RecipeFeedCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.cookingTime,
    required this.difficulty,
    required this.chefName,
    required this.chefAvatar,
    required this.likes,
    this.isLiked = false,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppConstants.radiusMedium),
            ),
            child: AspectRatio(
              aspectRatio: AppConstants.recipeCardAspectRatio,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Difficulty and Time badges
                    Positioned(
                      top: AppConstants.paddingSmall,
                      right: AppConstants.paddingSmall,
                      child: Row(
                        children: [
                          _buildBadge(cookingTime, Icons.access_time,
                              AppColors.secondary),
                          const SizedBox(width: 4),
                          _buildBadge(difficulty, Icons.bar_chart,
                              _getDifficultyColor()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingSmall),

                // Chef Info and Actions
                Row(
                  children: [
                    // Chef Avatar
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(chefAvatar),
                    ),
                    const SizedBox(width: AppConstants.paddingSmall),

                    // Chef Name
                    Text(
                      chefName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    // Action Buttons
                    Row(
                      children: [
                        _buildActionButton(
                          icon:
                              isLiked ? Icons.favorite : Icons.favorite_outline,
                          color: isLiked ? AppColors.like : AppColors.textLight,
                          label: likes.toString(),
                          onTap: () {},
                        ),
                        const SizedBox(width: AppConstants.paddingMedium),
                        _buildActionButton(
                          icon:
                              isSaved ? Icons.bookmark : Icons.bookmark_outline,
                          color: isSaved ? AppColors.save : AppColors.textLight,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    String? label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: color),
          if (label != null) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getDifficultyColor() {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppColors.difficultyEasy;
      case 'medium':
        return AppColors.difficultyMedium;
      case 'hard':
        return AppColors.difficultyHard;
      default:
        return AppColors.textLight;
    }
  }
}
