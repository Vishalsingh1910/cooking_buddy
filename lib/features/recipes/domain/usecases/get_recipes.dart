import '../../../../core/usecase/usecase.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipes implements UseCase<List<Recipe>, NoParams> {
  final RecipeRepository repository;
  GetRecipes(this.repository);

  @override
  Future<List<Recipe>> call(NoParams params) async {
    return await repository.getRecipes();
  }
}