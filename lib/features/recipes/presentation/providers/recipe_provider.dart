import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/usecases/get_recipes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../data/datasources/recipe_remote_data_source.dart';
import 'package:http/http.dart' as http;

final recipeRepositoryProvider = Provider((ref) {
  return RecipeRepositoryImpl(RecipeRemoteDataSourceImpl(http.Client()));
});

final getRecipesProvider = Provider((ref) {
  return GetRecipes(ref.watch(recipeRepositoryProvider));
});

final recipeListProvider = FutureProvider<List<Recipe>>((ref) async {
  final getRecipes = ref.watch(getRecipesProvider);
  return await getRecipes(NoParams());
});