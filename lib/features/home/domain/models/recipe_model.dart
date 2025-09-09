class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final String authorName;
  final String authorUsername;
  final String authorAvatar;
  final int cookTime;
  final double rating;
  final int servings;
  final String description;
  final List<String> ingredients;
  final String difficulty;
  final int likes;
  final int cooksCount;
  final bool isLiked;
  final bool isSaved;

  const Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.authorName,
    required this.authorUsername,
    required this.authorAvatar,
    required this.cookTime,
    required this.rating,
    required this.servings,
    required this.description,
    required this.ingredients,
    required this.difficulty,
    required this.likes,
    required this.cooksCount,
    this.isLiked = false,
    this.isSaved = false,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? authorName,
    String? authorUsername,
    String? authorAvatar,
    int? cookTime,
    double? rating,
    int? servings,
    String? description,
    List<String>? ingredients,
    String? difficulty,
    int? likes,
    int? cooksCount,
    bool? isLiked,
    bool? isSaved,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      authorName: authorName ?? this.authorName,
      authorUsername: authorUsername ?? this.authorUsername,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      cookTime: cookTime ?? this.cookTime,
      rating: rating ?? this.rating,
      servings: servings ?? this.servings,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      difficulty: difficulty ?? this.difficulty,
      likes: likes ?? this.likes,
      cooksCount: cooksCount ?? this.cooksCount,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
