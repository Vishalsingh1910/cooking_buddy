import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/recipe_feed_card.dart';
import '../widgets/ingredient_input_section.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  // App Logo
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusSmall),
                    ),
                    child: const Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'CookingBuddy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  // Search Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                        color: AppColors.textSecondary),
                  ),
                  // Notification Bell
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined,
                        color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            // Recipe Feed
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium),
                itemCount: 10, // Mock data
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppConstants.paddingMedium),
                    child: RecipeFeedCard(
                      imageUrl: 'https://picsum.photos/400/225?random=$index',
                      title: _getMockRecipeTitle(index),
                      cookingTime: _getMockCookingTime(index),
                      difficulty: _getMockDifficulty(index),
                      chefName: _getMockChefName(index),
                      chefAvatar:
                          'https://picsum.photos/40/40?random=${index + 100}',
                      likes: _getMockLikes(index),
                      isLiked: index % 3 == 0,
                      isSaved: index % 4 == 0,
                    ),
                  );
                },
              ),
            ),

            // Ingredient Input Section
            const IngredientInputSection(),
          ],
        ),
      ),
    );
  }

  String _getMockRecipeTitle(int index) {
    final titles = [
      'Creamy Mushroom Risotto',
      'Spicy Thai Basil Chicken',
      'Classic Margherita Pizza',
      'Honey Garlic Salmon',
      'Vegetarian Buddha Bowl',
      'Chocolate Lava Cake',
      'Mediterranean Quinoa Salad',
      'Korean BBQ Tacos',
      'Butternut Squash Soup',
      'Grilled Chicken Caesar',
    ];
    return titles[index % titles.length];
  }

  String _getMockCookingTime(int index) {
    final times = ['15 min', '30 min', '45 min', '1 hour', '25 min'];
    return times[index % times.length];
  }

  String _getMockDifficulty(int index) {
    final difficulties = ['Easy', 'Medium', 'Hard'];
    return difficulties[index % difficulties.length];
  }

  String _getMockChefName(int index) {
    final names = [
      'Chef Maria',
      'Gordon R.',
      'Julia C.',
      'Anthony B.',
      'Ina G.'
    ];
    return names[index % names.length];
  }

  int _getMockLikes(int index) {
    return (index + 1) * 23 + (index * 7);
  }
}
