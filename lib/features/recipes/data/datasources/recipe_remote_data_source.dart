import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRecipes();
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;
  RecipeRemoteDataSourceImpl(this.client);

  @override
  Future<List<RecipeModel>> getRecipes() async {
    final response = await client.get(Uri.parse("https://api.example.com/recipes"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load recipes");
    }
  }
}