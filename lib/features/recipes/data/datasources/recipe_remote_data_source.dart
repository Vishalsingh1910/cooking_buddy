import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';
import '../../domain/entities/recipe.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRecipes();
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;
  RecipeRemoteDataSourceImpl(this.client);

  @override
  Future<List<RecipeModel>> getRecipes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return sample data for now
    return _sampleRecipes;
  }
}

final List<RecipeModel> _sampleRecipes = [
  RecipeModel(
    id: '1',
    title: 'Creamy Mushroom Risotto',
    imageUrl:
        'https://images.unsplash.com/photo-1476124369491-e7addf5db371?w=800&h=600&fit=crop',
    authorName: 'Chef Ana',
    authorImageUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
    description:
        'Restaurant-quality risotto made simple. Creamy arborio rice with earthy mushrooms and parmesan.',
    likesCount: 1234,
    commentsCount: 89,
    cookingTimeMinutes: 35,
    rating: 4.8,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ingredients: [
      '1 cup arborio rice',
      '4 cups warm vegetable broth',
      '1 lb mixed mushrooms, sliced',
      '1/2 cup white wine',
      '1/2 cup parmesan cheese, grated',
      '2 tbsp butter',
      '1 onion, diced',
      '3 cloves garlic, minced',
      'Salt and pepper to taste',
    ],
    steps: [
      'Heat broth in a saucepan and keep warm.',
      'Sauté mushrooms until golden. Set aside.',
      'Cook onion and garlic until translucent.',
      'Add rice, stir for 2 minutes until lightly toasted.',
      'Add wine, stir until absorbed.',
      'Add broth one ladle at a time, stirring constantly.',
      'Continue until rice is creamy, about 18-20 minutes.',
      'Stir in mushrooms, butter, and parmesan.',
      'Season and serve immediately.',
    ],
    comments: [
      RecipeComment(
        id: '1',
        authorName: 'Mario',
        authorImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        text: 'Pro tip: Use a mix of shiitake and porcini for extra flavor!',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        likesCount: 12,
      ),
    ],
  ),
  RecipeModel(
    id: '2',
    title: '15-Minute Avocado Toast',
    imageUrl:
        'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?w=800&h=600&fit=crop',
    authorName: 'Sarah Green',
    authorImageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
    description:
        'Quick, healthy breakfast with perfectly ripe avocado, cherry tomatoes, and a drizzle of olive oil.',
    likesCount: 892,
    commentsCount: 45,
    cookingTimeMinutes: 10,
    rating: 4.6,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ingredients: [
      '2 slices sourdough bread',
      '1 ripe avocado',
      '1/2 cup cherry tomatoes, halved',
      '2 tbsp olive oil',
      '1 tbsp lemon juice',
      'Salt and pepper',
      'Red pepper flakes',
    ],
    steps: [
      'Toast bread until golden brown.',
      'Mash avocado with lemon juice, salt, and pepper.',
      'Spread avocado mixture on toast.',
      'Top with cherry tomatoes.',
      'Drizzle with olive oil and sprinkle red pepper flakes.',
    ],
    comments: [],
  ),
  RecipeModel(
    id: '3',
    title: 'Classic Margherita Pizza',
    imageUrl:
        'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=800&h=600&fit=crop',
    authorName: 'Gordon Ramsay',
    authorImageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
    description:
        'Authentic Italian Margherita with San Marzano tomatoes, fresh mozzarella, and basil.',
    likesCount: 2156,
    commentsCount: 132,
    cookingTimeMinutes: 25,
    rating: 4.9,
    createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    isLiked: true,
    ingredients: [
      '1 pizza dough ball',
      '1/2 cup San Marzano tomatoes, crushed',
      '8 oz fresh mozzarella',
      'Fresh basil leaves',
      '2 tbsp olive oil',
      '1 clove garlic, minced',
      'Salt to taste',
    ],
    steps: [
      'Preheat oven to 500°F (260°C).',
      'Roll out pizza dough on floured surface.',
      'Mix tomatoes with garlic and salt.',
      'Spread sauce evenly on dough.',
      'Add mozzarella slices.',
      'Drizzle with olive oil.',
      'Bake 10-12 minutes until golden.',
      'Top with fresh basil before serving.',
    ],
    comments: [
      RecipeComment(
        id: '3',
        authorName: 'Chef Ana',
        authorImageUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
        text: 'The secret is high heat and good quality ingredients!',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        likesCount: 15,
        isLiked: true,
      ),
    ],
  ),
  RecipeModel(
    id: '4',
    title: 'Vegan Buddha Bowl',
    imageUrl:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&h=600&fit=crop',
    authorName: 'Plant Chef',
    authorImageUrl:
        'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
    description:
        'Colorful, nutritious bowl with quinoa, roasted vegetables, and tahini dressing.',
    likesCount: 678,
    commentsCount: 34,
    cookingTimeMinutes: 30,
    rating: 4.7,
    createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    isSaved: true,
    ingredients: [
      '1 cup quinoa',
      '2 cups mixed vegetables',
      '1/4 cup tahini',
      '2 tbsp lemon juice',
      '1 tbsp maple syrup',
      '1 avocado, sliced',
      '2 tbsp pumpkin seeds',
      'Salt and pepper',
    ],
    steps: [
      'Cook quinoa according to package instructions.',
      'Roast vegetables at 400°F for 20 minutes.',
      'Whisk tahini, lemon juice, and maple syrup for dressing.',
      'Assemble bowl with quinoa, vegetables, and avocado.',
      'Drizzle with dressing and top with pumpkin seeds.',
    ],
    comments: [],
  ),
  RecipeModel(
    id: '5',
    title: 'Chocolate Lava Cake',
    imageUrl:
        'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=800&h=600&fit=crop',
    authorName: 'Pastry Sarah',
    authorImageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
    description:
        'Decadent individual chocolate cakes with molten centers. Perfect for date nights!',
    likesCount: 1567,
    commentsCount: 78,
    cookingTimeMinutes: 15,
    rating: 4.9,
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ingredients: [
      '4 oz dark chocolate',
      '4 tbsp butter',
      '2 large eggs',
      '2 tbsp sugar',
      '2 tbsp flour',
      'Pinch of salt',
      'Butter for ramekins',
      'Cocoa powder',
    ],
    steps: [
      'Preheat oven to 425°F (220°C).',
      'Butter ramekins and dust with cocoa.',
      'Melt chocolate and butter in double boiler.',
      'Whisk eggs and sugar until thick.',
      'Fold in chocolate mixture, then flour.',
      'Divide between ramekins.',
      'Bake 12-14 minutes until edges are firm.',
      'Cool 1 minute, then invert onto plates.',
    ],
    comments: [
      RecipeComment(
        id: '4',
        authorName: 'Dessert Lover',
        authorImageUrl:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
        text: 'Made this for my anniversary - absolutely perfect! 🍫❤️',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        likesCount: 22,
      ),
    ],
  ),
];
