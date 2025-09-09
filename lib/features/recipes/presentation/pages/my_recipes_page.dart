import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/recipe_grid_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class MyRecipesPage extends ConsumerWidget {
  const MyRecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  const Text(
                    'My Recipes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  // Add New Recipe Button
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusSmall),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Navigate to add recipe page
                      },
                      icon: const Icon(Icons.add, color: Colors.white),
                      tooltip: 'Add New Recipe',
                    ),
                  ),
                ],
              ),
            ),

            // Toggle Tabs
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusMedium),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(
                        'My Posts',
                        0,
                        selectedTab,
                        () => ref.read(selectedTabProvider.notifier).state = 0,
                      ),
                    ),
                    Expanded(
                      child: _buildTabButton(
                        'Saved Recipes',
                        1,
                        selectedTab,
                        () => ref.read(selectedTabProvider.notifier).state = 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.paddingMedium),

            // Content
            Expanded(
              child: selectedTab == 0
                  ? _buildMyPostsGrid()
                  : _buildSavedRecipesGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(
      String title, int index, int selectedTab, VoidCallback onTap) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.animationFast,
        padding:
            const EdgeInsets.symmetric(vertical: AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMyPostsGrid() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppConstants.paddingMedium,
          mainAxisSpacing: AppConstants.paddingMedium,
          childAspectRatio: 0.8,
        ),
        itemCount: 12, // Mock data
        itemBuilder: (context, index) {
          return RecipeGridCard(
            imageUrl: 'https://picsum.photos/200/200?random=${index + 200}',
            title: _getMockRecipeTitle(index),
            likes: _getMockLikes(index),
            comments: _getMockComments(index),
            isOwned: true,
          );
        },
      ),
    );
  }

  Widget _buildSavedRecipesGrid() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppConstants.paddingMedium,
          mainAxisSpacing: AppConstants.paddingMedium,
          childAspectRatio: 0.8,
        ),
        itemCount: 8, // Mock data
        itemBuilder: (context, index) {
          return RecipeGridCard(
            imageUrl: 'https://picsum.photos/200/200?random=${index + 300}',
            title: _getMockSavedRecipeTitle(index),
            likes: _getMockLikes(index),
            comments: _getMockComments(index),
            isOwned: false,
            chefName: _getMockChefName(index),
          );
        },
      ),
    );
  }

  String _getMockRecipeTitle(int index) {
    final titles = [
      'My Famous Pasta',
      'Grandma\'s Cookies',
      'Spicy Curry Bowl',
      'Fresh Garden Salad',
      'Homemade Pizza',
      'Chocolate Brownies',
      'Grilled Vegetables',
      'Creamy Soup',
      'Fruit Smoothie',
      'Baked Chicken',
      'Veggie Stir Fry',
      'Apple Pie',
    ];
    return titles[index % titles.length];
  }

  String _getMockSavedRecipeTitle(int index) {
    final titles = [
      'Italian Carbonara',
      'Thai Green Curry',
      'French Croissants',
      'Japanese Ramen',
      'Mexican Tacos',
      'Indian Biryani',
      'Greek Salad',
      'Korean Kimchi',
    ];
    return titles[index % titles.length];
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
    return (index + 1) * 15 + (index * 3);
  }

  int _getMockComments(int index) {
    return (index + 1) * 5 + (index * 2);
  }
}
