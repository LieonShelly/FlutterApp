import 'package:basic_widgets/data/repositories/repository.dart';
import 'package:basic_widgets/models/ingredient.dart';
import 'package:basic_widgets/models/recipe.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/current_recipe_data.dart';

class MemoryRepository extends Notifier<CurrentRecipeData>
    implements Repository {
  @override
  CurrentRecipeData build() {
    const currentRecipeData = CurrentRecipeData();
    return currentRecipeData;
  }

  @override
  void close() {}

  @override
  void deleteIngredient(Ingredient ingredient) {
    final updateList = [...state.curentIngredients];
    updateList.remove(ingredient);
    state = state.copyWith(curentIngredients: updateList);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    final updatedList = [...state.curentIngredients];
    updatedList.removeWhere((ingredient) => ingredients.contains(ingredient));
    state = state.copyWith(curentIngredients: updatedList);
  }

  @override
  void deleteRecipe(Recipe recipe) {
    final updatedList = [...state.currentRecipes];
    updatedList.remove(recipe);
    state = state.copyWith(currentRecipes: updatedList);
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    final updatedList = [...state.curentIngredients];
    updatedList.removeWhere((ingredient) => ingredient.recipeId == recipeId);
    state = state.copyWith(curentIngredients: updatedList);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return state.curentIngredients;
  }

  @override
  List<Recipe> findAllRecipes() {
    return state.currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return state.currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe = state.currentRecipes.firstWhere(
      (recipe) => recipe.id == recipeId,
    );
    final recipeIngredients = state.curentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return recipeIngredients;
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      state = state.copyWith(
        curentIngredients: [...state.curentIngredients, ...ingredients],
      );
    }
    return [];
  }

  @override
  int insertRecipe(Recipe recipe) {
    if (state.currentRecipes.contains(recipe)) {
      return 0;
    }
    state = state.copyWith(currentRecipes: [...state.currentRecipes, recipe]);
    insertIngredients(recipe.ingredients);
    return 0;
  }
}
