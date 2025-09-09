import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class ProfileRecipeGrid extends StatelessWidget {
  const ProfileRecipeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppConstants.paddingSmall,
        mainAxisSpacing: AppConstants.paddingSmall,
        childAspectRatio: 1.0,
      ),
      itemCount: 9, // Show first 9 recipes
      itemBuilder: (context, index) {
        return _buildRecipeGridItem(index);
      },
    );
  }

  Widget _buildRecipeGridItem(int index) {
    final recipes = [
      'Creamy Mushroom Risotto',
      'Spicy Thai Basil Chicken',
      'Classic Margherita Pizza',
      'Honey Garlic Salmon',
      'Vegetarian Buddha Bowl',
      'Chocolate Lava Cake',
      'Mediterranean Quinoa Salad',
      'Korean BBQ Tacos',
      'Butternut Squash Soup',
    ];

    return GestureDetector(
      onTap: () {
        // Navigate to recipe detail
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
          image: DecorationImage(
            image: NetworkImage(
                'https://picsum.photos/150/150?random=${index + 500}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingSmall),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipes[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: AppColors.like,
                      size: 12,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${(index + 1) * 12}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
