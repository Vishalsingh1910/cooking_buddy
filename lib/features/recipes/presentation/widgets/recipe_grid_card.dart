import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class RecipeGridCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int likes;
  final int comments;
  final bool isOwned;
  final String? chefName;

  const RecipeGridCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.likes,
    required this.comments,
    this.isOwned = false,
    this.chefName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recipe Image
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusMedium),
              ),
              child: Container(
                width: double.infinity,
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
                              Colors.black.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Action buttons overlay
                    Positioned(
                      bottom: AppConstants.paddingSmall,
                      right: AppConstants.paddingSmall,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildOverlayButton(
                            Icons.favorite_outline,
                            AppColors.like,
                            () {},
                          ),
                          const SizedBox(width: 4),
                          _buildOverlayButton(
                            Icons.chat_bubble_outline,
                            AppColors.secondary,
                            () {},
                          ),
                          const SizedBox(width: 4),
                          _buildOverlayButton(
                            Icons.share_outlined,
                            AppColors.primary,
                            () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppConstants.paddingSmall),

                  // Chef name (for saved recipes)
                  if (!isOwned && chefName != null) ...[
                    Text(
                      'by $chefName',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppConstants.paddingSmall),
                  ],

                  const Spacer(),

                  // Engagement metrics
                  Row(
                    children: [
                      _buildMetric(Icons.favorite_outline, likes.toString(),
                          AppColors.like),
                      const SizedBox(width: AppConstants.paddingMedium),
                      _buildMetric(Icons.chat_bubble_outline,
                          comments.toString(), AppColors.secondary),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        ),
        child: Icon(
          icon,
          size: 16,
          color: color,
        ),
      ),
    );
  }

  Widget _buildMetric(IconData icon, String count, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          count,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
