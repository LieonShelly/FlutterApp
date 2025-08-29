import 'package:basic_widgets/data/repositories/memory_repository.dart';
import 'package:basic_widgets/models/current_recipe_data.dart';
import 'package:basic_widgets/network/service_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final serviceProvider = Provider<ServiceInterface>((ref) {
  throw UnimplementedError();
});

final repositoryProvider =
    NotifierProvider<MemoryRepository, CurrentRecipeData>(() {
      return MemoryRepository();
    });
