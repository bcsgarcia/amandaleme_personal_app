import 'package:formz/formz.dart';

/// Validation erros for the [Email] [FormzInput]
enum EmailValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input
/// {@endtemplate}
class EmailInput extends FormzInput<String, EmailValidationError>
    with FormzInputErrorCacheMixin {
  /// {@macro email}
  EmailInput.pure([super.value = '']) : super.pure();

  /// {@macro email}
  EmailInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}
