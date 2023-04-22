part of 'login_cubit.dart';

class LoginState extends Equatable with FormzMixin {
  LoginState({
    EmailInput? emailInput,
    this.passInput = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
  }) : emailInput = emailInput ?? EmailInput.pure();

  final EmailInput emailInput;
  final PasswordInput passInput;
  final FormzSubmissionStatus status;

  LoginState copyWith({
    EmailInput? emailInput,
    PasswordInput? passInput,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      emailInput: emailInput ?? this.emailInput,
      passInput: passInput ?? this.passInput,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [emailInput, passInput, status];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [emailInput, passInput];
}
