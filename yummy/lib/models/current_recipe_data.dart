import 'package:basic_widgets/models/ingredient.dart';
import 'package:basic_widgets/models/recipe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_recipe_data.freezed.dart';

@freezed
class CurrentRecipeData with _$CurrentRecipeData {
  const factory CurrentRecipeData({
    @Default(<Recipe>[]) List<Recipe> currentRecipes,
    @Default(<Ingredient>[]) List<Ingredient> curentIngredients,
  }) = _CurrentRecipeData;
}
