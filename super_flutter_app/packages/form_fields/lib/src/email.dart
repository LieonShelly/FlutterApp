import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class Email extends FormzInput<String, EmailValidationError>
    with EquatableMixin {
  const Email.unvalidate([String value = ''])
    : isAlreadyRegistered = false,
      super.pure(value);

  final bool isAlreadyRegistered;

  const Email.validated(String value, {this.isAlreadyRegistered = false})
    : super.dirty(value);

  static final _emailRegex = RegExp(
    '^(([\\w-]+\\.)+[\\w-]+|([a-zA-Z]|[\\w-]{2,}))@((([0-1]?'
    '[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.'
    '([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])'
    ')|([a-zA-Z]+[\\w-]+\\.)+[a-zA-Z]{2,4})\$',
  );

  @override
  EmailValidationError? validator(String value) {
    return value.isEmpty
        ? EmailValidationError.empty
        : (isAlreadyRegistered
              ? EmailValidationError.alreadRegistered
              : (_emailRegex.hasMatch(value)
                    ? null
                    : EmailValidationError.invalid));
  }

  @override
  List<Object?> get props => [value, pure, isAlreadyRegistered];
}

enum EmailValidationError { empty, invalid, alreadRegistered }
