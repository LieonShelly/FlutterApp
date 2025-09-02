import 'package:basic_widgets/data/repositories/db_repository.dart';
import 'package:basic_widgets/data/repositories/memory_repository.dart';
import 'package:basic_widgets/data/repositories/repository.dart';
import 'package:basic_widgets/models/current_recipe_data.dart';
import 'package:basic_widgets/network/service_interface.dart';
import 'package:basic_widgets/ui/recipe_main_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final serviceProvider = Provider<ServiceInterface>((ref) {
  throw UnimplementedError();
});

final repositoryProvider = NotifierProvider<DBRepository, CurrentRecipeData>(
  () {
    throw UnimplementedError();
  },
);

final bottomNavigatioProvider =
    StateNotifierProvider<RecipeMainScreenStateProvider, RecipeMainScreenState>(
      (ref) {
        return RecipeMainScreenStateProvider();
      },
    );
