class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final String authorName;
  final String authorImageUrl;
  final String description;
  final int likesCount;
  final int commentsCount;
  final int cookingTimeMinutes;
  final double rating;
  final DateTime createdAt;
  final bool isLiked;
  final bool isSaved;
  final List<String> ingredients;
  final List<String> steps;
  final List<RecipeComment> comments;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.authorName,
    required this.authorImageUrl,
    required this.description,
    required this.likesCount,
    required this.commentsCount,
    required this.cookingTimeMinutes,
    required this.rating,
    required this.createdAt,
    this.isLiked = false,
    this.isSaved = false,
    this.ingredients = const [],
    this.steps = const [],
    this.comments = const [],
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? authorName,
    String? authorImageUrl,
    String? description,
    int? likesCount,
    int? commentsCount,
    int? cookingTimeMinutes,
    double? rating,
    DateTime? createdAt,
    bool? isLiked,
    bool? isSaved,
    List<String>? ingredients,
    List<String>? steps,
    List<RecipeComment>? comments,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      authorName: authorName ?? this.authorName,
      authorImageUrl: authorImageUrl ?? this.authorImageUrl,
      description: description ?? this.description,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      cookingTimeMinutes: cookingTimeMinutes ?? this.cookingTimeMinutes,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      comments: comments ?? this.comments,
    );
  }
}

class RecipeComment {
  final String id;
  final String authorName;
  final String authorImageUrl;
  final String text;
  final DateTime createdAt;
  final int likesCount;
  final bool isLiked;

  RecipeComment({
    required this.id,
    required this.authorName,
    required this.authorImageUrl,
    required this.text,
    required this.createdAt,
    required this.likesCount,
    this.isLiked = false,
  });
}
