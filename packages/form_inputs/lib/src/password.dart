import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template password}
/// Form input for an password input.
/// {@endtemplate}
class PasswordInput extends FormzInput<String, PasswordValidationError> {
  /// {@macro password}
  const PasswordInput.pure() : super.pure('');

  /// {@macro password}
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String? value) {
    return PasswordValidationError.invalid;
  }
}
