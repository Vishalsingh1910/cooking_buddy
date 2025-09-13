import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/recipe.dart';
import '../widgets/ai_recipe_card.dart';
import 'ai_recipe_detail_page.dart';

class AIRecipeResultsPage extends ConsumerWidget {
  final List<String> ingredients;

  const AIRecipeResultsPage({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock AI-generated recipes for now
    final aiRecipes = _generateMockAIRecipes(ingredients);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Recipe Results',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Recipes with ${ingredients.join(", ")}',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  'AI Generated',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Ingredients Summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondary.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.kitchen,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Your Ingredients',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: ingredients.map((ingredient) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ingredient,
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Recipe Results
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: aiRecipes.length,
              itemBuilder: (context, index) {
                final recipe = aiRecipes[index];
                return AIRecipeCard(
                  recipe: recipe,
                  userIngredients: ingredients,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AIRecipeDetailPage(
                          recipe: recipe,
                          userIngredients: ingredients,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Regenerate recipes with AI
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🤖 Generating new recipe ideas...'),
              backgroundColor: AppColors.primary,
            ),
          );
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.refresh, color: Colors.white),
        label: const Text(
          'Regenerate',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

List<Recipe> _generateMockAIRecipes(List<String> ingredients) {
  // Mock AI-generated recipes based on ingredients
  return [
    Recipe(
      id: 'ai_1',
      title: '${ingredients.join(" & ")} Fusion Bowl',
      imageUrl:
          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&h=600&fit=crop',
      authorName: 'AI Chef',
      authorImageUrl:
          'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=150&h=150&fit=crop',
      description:
          'AI-crafted recipe using your available ingredients with creative combinations.',
      likesCount: 0,
      commentsCount: 0,
      cookingTimeMinutes: 25,
      rating: 4.5,
      createdAt: DateTime.now(),
      ingredients: [
        ...ingredients.map((ing) => '1 cup $ing'),
        '2 tbsp olive oil',
        'Salt and pepper to taste',
        '1 tsp garlic powder',
      ],
      steps: [
        'Prepare all your ingredients by washing and chopping as needed.',
        'Heat olive oil in a large pan over medium heat.',
        'Add ${ingredients.first} and cook for 3-4 minutes.',
        'Add remaining ingredients and season with salt, pepper, and garlic powder.',
        'Cook for 15-20 minutes, stirring occasionally.',
        'Taste and adjust seasoning as needed.',
        'Serve hot and enjoy your AI-created dish!',
      ],
      comments: [],
    ),
    Recipe(
      id: 'ai_2',
      title: 'Quick ${ingredients.first} Stir-Fry',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&h=600&fit=crop',
      authorName: 'AI Chef',
      authorImageUrl:
          'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=150&h=150&fit=crop',
      description:
          'Fast and healthy stir-fry recipe optimized for your ingredients.',
      likesCount: 0,
      commentsCount: 0,
      cookingTimeMinutes: 15,
      rating: 4.3,
      createdAt: DateTime.now(),
      ingredients: [
        ...ingredients.map((ing) => '1 cup $ing'),
        '2 tbsp soy sauce',
        '1 tbsp sesame oil',
        '1 tsp ginger, minced',
        '2 cloves garlic, minced',
      ],
      steps: [
        'Heat sesame oil in a wok or large skillet.',
        'Add garlic and ginger, stir-fry for 30 seconds.',
        'Add ${ingredients.join(", ")} in order of cooking time needed.',
        'Stir-fry for 8-10 minutes until tender-crisp.',
        'Add soy sauce and toss to combine.',
        'Serve immediately over rice or noodles.',
      ],
      comments: [],
    ),
    Recipe(
      id: 'ai_3',
      title: 'Comfort ${ingredients.last} Soup',
      imageUrl:
          'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&h=600&fit=crop',
      authorName: 'AI Chef',
      authorImageUrl:
          'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=150&h=150&fit=crop',
      description:
          'Warming soup recipe that makes the most of your available ingredients.',
      likesCount: 0,
      commentsCount: 0,
      cookingTimeMinutes: 40,
      rating: 4.7,
      createdAt: DateTime.now(),
      ingredients: [
        ...ingredients.map((ing) => '2 cups $ing, chopped'),
        '4 cups vegetable broth',
        '1 bay leaf',
        '1 tsp thyme',
        'Salt and pepper to taste',
      ],
      steps: [
        'In a large pot, sauté ${ingredients.first} until softened.',
        'Add remaining vegetables and cook for 5 minutes.',
        'Pour in vegetable broth and add bay leaf and thyme.',
        'Bring to a boil, then reduce heat and simmer for 25 minutes.',
        'Season with salt and pepper to taste.',
        'Remove bay leaf before serving.',
        'Serve hot with crusty bread.',
      ],
      comments: [],
    ),
  ];
}
