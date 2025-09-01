// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_main_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecipeMainScreenState {
  int get selectedIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeMainScreenStateCopyWith<RecipeMainScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeMainScreenStateCopyWith<$Res> {
  factory $RecipeMainScreenStateCopyWith(RecipeMainScreenState value,
          $Res Function(RecipeMainScreenState) then) =
      _$RecipeMainScreenStateCopyWithImpl<$Res, RecipeMainScreenState>;
  @useResult
  $Res call({int selectedIndex});
}

/// @nodoc
class _$RecipeMainScreenStateCopyWithImpl<$Res,
        $Val extends RecipeMainScreenState>
    implements $RecipeMainScreenStateCopyWith<$Res> {
  _$RecipeMainScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
  }) {
    return _then(_value.copyWith(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeMainScreenStateImplCopyWith<$Res>
    implements $RecipeMainScreenStateCopyWith<$Res> {
  factory _$$RecipeMainScreenStateImplCopyWith(
          _$RecipeMainScreenStateImpl value,
          $Res Function(_$RecipeMainScreenStateImpl) then) =
      __$$RecipeMainScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedIndex});
}

/// @nodoc
class __$$RecipeMainScreenStateImplCopyWithImpl<$Res>
    extends _$RecipeMainScreenStateCopyWithImpl<$Res,
        _$RecipeMainScreenStateImpl>
    implements _$$RecipeMainScreenStateImplCopyWith<$Res> {
  __$$RecipeMainScreenStateImplCopyWithImpl(_$RecipeMainScreenStateImpl _value,
      $Res Function(_$RecipeMainScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedIndex = null,
  }) {
    return _then(_$RecipeMainScreenStateImpl(
      selectedIndex: null == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RecipeMainScreenStateImpl implements _RecipeMainScreenState {
  const _$RecipeMainScreenStateImpl({this.selectedIndex = 0});

  @override
  @JsonKey()
  final int selectedIndex;

  @override
  String toString() {
    return 'RecipeMainScreenState(selectedIndex: $selectedIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeMainScreenStateImpl &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeMainScreenStateImplCopyWith<_$RecipeMainScreenStateImpl>
      get copyWith => __$$RecipeMainScreenStateImplCopyWithImpl<
          _$RecipeMainScreenStateImpl>(this, _$identity);
}

abstract class _RecipeMainScreenState implements RecipeMainScreenState {
  const factory _RecipeMainScreenState({final int selectedIndex}) =
      _$RecipeMainScreenStateImpl;

  @override
  int get selectedIndex;
  @override
  @JsonKey(ignore: true)
  _$$RecipeMainScreenStateImplCopyWith<_$RecipeMainScreenStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
