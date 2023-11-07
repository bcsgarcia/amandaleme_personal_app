part of 'login_cubit.dart';

class LoginState extends Equatable with FormzMixin {
  LoginState({
    EmailInput? emailInput,
    this.passInput = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.keepConnected = false,
  }) : emailInput = emailInput ?? EmailInput.pure();

  final EmailInput emailInput;
  final PasswordInput passInput;
  final FormzSubmissionStatus status;
  final bool keepConnected;

  LoginState copyWith({
    EmailInput? emailInput,
    PasswordInput? passInput,
    FormzSubmissionStatus? status,
    bool? keepConnected,
  }) {
    return LoginState(
      emailInput: emailInput ?? this.emailInput,
      passInput: passInput ?? this.passInput,
      status: status ?? this.status,
      keepConnected: keepConnected ?? this.keepConnected,
    );
  }

  @override
  List<Object?> get props => [emailInput, passInput, status, keepConnected];

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [emailInput, passInput];
}
