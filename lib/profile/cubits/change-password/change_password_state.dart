part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable with FormzMixin {
  ChangePasswordState({
    this.oldPass = const PasswordInput.pure(),
    this.viewOldPass = true,
    this.newPass = const PasswordInput.pure(),
    this.viewNewPass = true,
    this.confirmedNewPass = const ConfirmedPassword.pure(),
    this.viewConfirmedNewPass = true,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final PasswordInput oldPass;
  final bool viewOldPass;
  final PasswordInput newPass;
  final bool viewNewPass;
  final ConfirmedPassword confirmedNewPass;
  final bool viewConfirmedNewPass;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  ChangePasswordState copyWith({
    PasswordInput? oldPass,
    bool? viewOldPass,
    PasswordInput? newPass,
    bool? viewNewPass,
    ConfirmedPassword? confirmedNewPass,
    bool? viewConfirmedNewPass,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      oldPass: oldPass ?? this.oldPass,
      viewOldPass: viewOldPass ?? this.viewOldPass,
      newPass: newPass ?? this.newPass,
      viewNewPass: viewNewPass ?? this.viewNewPass,
      confirmedNewPass: confirmedNewPass ?? this.confirmedNewPass,
      viewConfirmedNewPass: viewConfirmedNewPass ?? this.viewConfirmedNewPass,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<FormzInput> get inputs => [oldPass, newPass, confirmedNewPass];

  @override
  List<Object?> get props => [oldPass, newPass, confirmedNewPass, status, viewOldPass, viewNewPass, viewConfirmedNewPass, isValid, errorMessage];
}
