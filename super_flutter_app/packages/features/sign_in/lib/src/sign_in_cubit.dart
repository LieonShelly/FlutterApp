import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final UserRepository userRepository;
}
