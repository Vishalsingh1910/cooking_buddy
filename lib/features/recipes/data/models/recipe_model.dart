import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({required String id, required String title, required String imageUrl})
      : super(id: id, title: title, imageUrl: imageUrl);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'].toString(),
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}