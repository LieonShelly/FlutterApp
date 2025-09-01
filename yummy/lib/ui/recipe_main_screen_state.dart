import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'recipe_main_screen_state.freezed.dart';

@freezed
class RecipeMainScreenState with _$RecipeMainScreenState {
  const factory RecipeMainScreenState({@Default(0) int selectedIndex}) =
      _RecipeMainScreenState;
}

class RecipeMainScreenStateProvider
    extends StateNotifier<RecipeMainScreenState> {
  RecipeMainScreenStateProvider() : super(const RecipeMainScreenState());

  void updateSelectedIndex(int index) {
    state = RecipeMainScreenState(selectedIndex: index);
  }
}
