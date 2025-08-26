import 'package:basic_widgets/models/recipe.dart';
import 'package:basic_widgets/network/model_reponse.dart';
import 'package:basic_widgets/network/query_result.dart';

typedef RecipeResponse = Result<QueryResult>;
typedef RecipeDetailResponse = Result<Recipe>;

abstract class ServiceInterface {
  Future<RecipeResponse> queryRecipes(String query, int offset, int number);

  Future<RecipeDetailResponse> queryRecipe(String id);
}
