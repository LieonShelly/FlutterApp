import 'dart:async';

import 'package:basic_widgets/data/repositories/repository.dart';
import 'package:basic_widgets/models/ingredient.dart';
import 'package:basic_widgets/models/recipe.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/current_recipe_data.dart';

class MemoryRepository extends Notifier<CurrentRecipeData>
    implements Repository {
  late Stream<List<Recipe>> _recipeStream;
  late Stream<List<Ingredient>> _ingredientStrem;
  final StreamController _recipeStreamController =
      StreamController<List<Recipe>>();
  final StreamController _ingredientStreamContoller =
      StreamController<List<Ingredient>>();

  MemoryRepository() {
    _recipeStream =
        _recipeStreamController.stream.asBroadcastStream(
              onListen: (subscription) {
                _recipeStreamController.sink.add(state.currentRecipes);
              },
            )
            as Stream<List<Recipe>>;

    _ingredientStrem =
        _ingredientStreamContoller.stream.asBroadcastStream(
              onListen: (subscription) {
                _ingredientStreamContoller.sink.add(state.curentIngredients);
              },
            )
            as Stream<List<Ingredient>>;
  }

  @override
  CurrentRecipeData build() {
    const currentRecipeData = CurrentRecipeData();
    return currentRecipeData;
  }

  @override
  void close() {}

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    final updateList = [...state.curentIngredients];
    updateList.remove(ingredient);
    state = state.copyWith(curentIngredients: updateList);

    _ingredientStreamContoller.sink.add(state.curentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    final updatedList = [...state.curentIngredients];
    updatedList.removeWhere((ingredient) => ingredients.contains(ingredient));
    state = state.copyWith(curentIngredients: updatedList);

    _ingredientStreamContoller.sink.add(state.curentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    final updatedList = [...state.currentRecipes];
    updatedList.remove(recipe);
    state = state.copyWith(currentRecipes: updatedList);
    _recipeStreamController.sink.add(state.currentRecipes);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    final updatedList = [...state.curentIngredients];
    updatedList.removeWhere((ingredient) => ingredient.recipeId == recipeId);
    state = state.copyWith(curentIngredients: updatedList);

    _ingredientStreamContoller.sink.add(state.curentIngredients);
    return Future.value();
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return Future.value(state.curentIngredients);
  }

  @override
  Future<List<Recipe>> findAllRecipes() {
    return Future.value(state.currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(
      state.currentRecipes.firstWhere((recipe) => recipe.id == id),
    );
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    final recipe = state.currentRecipes.firstWhere(
      (recipe) => recipe.id == recipeId,
    );
    final recipeIngredients = state.curentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      state = state.copyWith(
        curentIngredients: [...state.curentIngredients, ...ingredients],
      );
      _ingredientStreamContoller.sink.add(state.curentIngredients);
    }
    return Future.value([]);
  }

  @override
  Future<int> insertRecipe(Recipe recipe) {
    if (state.currentRecipes.contains(recipe)) {
      return Future.value(0);
    }
    state = state.copyWith(currentRecipes: [...state.currentRecipes, recipe]);
    _recipeStreamController.sink.add(state.currentRecipes);
    insertIngredients(recipe.ingredients);
    return Future.value(0);
  }

  @override
  Stream<List<Recipe>> watchAlRecipes() {
    return _recipeStream;
  }

  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    return _ingredientStrem;
  }
}
