import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/recipe_model.dart';
import '../../domain/models/ingredient_model.dart';

// Selected ingredients provider
final selectedIngredientsProvider =
    StateNotifierProvider<SelectedIngredientsNotifier, List<Ingredient>>((ref) {
  return SelectedIngredientsNotifier();
});

class SelectedIngredientsNotifier extends StateNotifier<List<Ingredient>> {
  SelectedIngredientsNotifier() : super([]);

  void addIngredient(Ingredient ingredient) {
    if (!state.contains(ingredient)) {
      state = [...state, ingredient];
    }
  }

  void removeIngredient(Ingredient ingredient) {
    state = state.where((item) => item != ingredient).toList();
  }

  void clearAll() {
    state = [];
  }
}

// Recipe feed provider
final recipeFeedProvider =
    StateNotifierProvider<RecipeFeedNotifier, AsyncValue<List<Recipe>>>((ref) {
  return RecipeFeedNotifier();
});

class RecipeFeedNotifier extends StateNotifier<AsyncValue<List<Recipe>>> {
  RecipeFeedNotifier() : super(const AsyncValue.loading()) {
    loadRecipes();
  }

  Future<void> loadRecipes() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      final recipes = _generateMockRecipes();
      state = AsyncValue.data(recipes);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshRecipes() async {
    state = const AsyncValue.loading();
    await loadRecipes();
  }

  void toggleLike(String recipeId) {
    state.whenData((recipes) {
      final updatedRecipes = recipes.map((recipe) {
        if (recipe.id == recipeId) {
          return recipe.copyWith(
            isLiked: !recipe.isLiked,
            likes: recipe.isLiked ? recipe.likes - 1 : recipe.likes + 1,
          );
        }
        return recipe;
      }).toList();
      state = AsyncValue.data(updatedRecipes);
    });
  }

  void toggleSave(String recipeId) {
    state.whenData((recipes) {
      final updatedRecipes = recipes.map((recipe) {
        if (recipe.id == recipeId) {
          return recipe.copyWith(isSaved: !recipe.isSaved);
        }
        return recipe;
      }).toList();
      state = AsyncValue.data(updatedRecipes);
    });
  }

  List<Recipe> _generateMockRecipes() {
    return [
      const Recipe(
        id: '1',
        title: 'Creamy Mushroom Risotto',
        imageUrl:
            'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=800',
        authorName: 'Chef Maria',
        authorUsername: 'chef_maria',
        authorAvatar:
            'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
        cookTime: 35,
        rating: 4.8,
        servings: 4,
        description:
            'Rich and creamy risotto with wild mushrooms and parmesan cheese. Perfect comfort food for any occasion.',
        ingredients: ['Arborio rice', 'Mushrooms', 'Parmesan', 'White wine'],
        difficulty: 'Medium',
        likes: 1247,
        cooksCount: 1200,
      ),
      const Recipe(
        id: '2',
        title: 'Spicy Thai Basil Chicken',
        imageUrl:
            'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=800',
        authorName: 'Thai Kitchen',
        authorUsername: 'thai_kitchen',
        authorAvatar:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
        cookTime: 20,
        rating: 4.6,
        servings: 2,
        description:
            'Authentic Thai stir-fry with fresh basil, chilies, and tender chicken. Quick and flavorful weeknight dinner.',
        ingredients: ['Chicken', 'Thai basil', 'Chilies', 'Fish sauce'],
        difficulty: 'Easy',
        likes: 892,
        cooksCount: 2100,
      ),
      const Recipe(
        id: '3',
        title: 'Classic Beef Wellington',
        imageUrl:
            'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=800',
        authorName: 'Gordon Chef',
        authorUsername: 'gordon_chef',
        authorAvatar:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
        cookTime: 120,
        rating: 4.9,
        servings: 6,
        description:
            'Elegant beef tenderloin wrapped in puff pastry with mushroom duxelles. A show-stopping centerpiece.',
        ingredients: [
          'Beef tenderloin',
          'Puff pastry',
          'Mushrooms',
          'Prosciutto'
        ],
        difficulty: 'Hard',
        likes: 2156,
        cooksCount: 450,
      ),
    ];
  }
}

// Quick filters provider
final selectedFilterProvider = StateProvider<String?>((ref) => null);

// Ingredient suggestions provider
final ingredientSuggestionsProvider = Provider<List<Ingredient>>((ref) {
  return [
    const Ingredient(id: '1', name: 'Chicken', category: 'Protein'),
    const Ingredient(id: '2', name: 'Beef', category: 'Protein'),
    const Ingredient(id: '3', name: 'Salmon', category: 'Protein'),
    const Ingredient(id: '4', name: 'Mushrooms', category: 'Vegetables'),
    const Ingredient(id: '5', name: 'Tomatoes', category: 'Vegetables'),
    const Ingredient(id: '6', name: 'Onions', category: 'Vegetables'),
    const Ingredient(id: '7', name: 'Garlic', category: 'Vegetables'),
    const Ingredient(id: '8', name: 'Rice', category: 'Grains'),
    const Ingredient(id: '9', name: 'Pasta', category: 'Grains'),
    const Ingredient(id: '10', name: 'Cheese', category: 'Dairy'),
  ];
});

// Recipe count based on ingredients
final recipeCountProvider = Provider<int>((ref) {
  final selectedIngredients = ref.watch(selectedIngredientsProvider);
  // Mock calculation - in real app, this would be based on API response
  return selectedIngredients.length * 3 + 2;
});
