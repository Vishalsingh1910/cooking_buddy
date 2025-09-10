import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.authorName,
    required super.authorImageUrl,
    required super.description,
    required super.likesCount,
    required super.commentsCount,
    required super.cookingTimeMinutes,
    required super.rating,
    required super.createdAt,
    super.isLiked,
    super.isSaved,
    super.ingredients,
    super.steps,
    super.comments,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'].toString(),
      title: json['title'],
      imageUrl: json['image_url'],
      authorName: json['author_name'],
      authorImageUrl: json['author_image_url'],
      description: json['description'],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      cookingTimeMinutes: json['cooking_time_minutes'],
      rating: json['rating'].toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      isLiked: json['is_liked'] ?? false,
      isSaved: json['is_saved'] ?? false,
      ingredients: List<String>.from(json['ingredients'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
      comments: (json['comments'] as List?)
              ?.map((c) => RecipeComment(
                    id: c['id'].toString(),
                    authorName: c['author_name'],
                    authorImageUrl: c['author_image_url'],
                    text: c['text'],
                    createdAt: DateTime.parse(c['created_at']),
                    likesCount: c['likes_count'],
                    isLiked: c['is_liked'] ?? false,
                  ))
              .toList() ??
          [],
    );
  }
}
