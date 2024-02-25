// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._userRepository) : super(ChangePasswordState());

  final UserRepository _userRepository;

  void oldPassChanged(String value) {
    final oldPass = PasswordInput.dirty(value);
    emit(state.copyWith(oldPass: oldPass, status: FormzSubmissionStatus.initial));
  }

  void newPassChanged(String value) {
    final newPass = PasswordInput.dirty(value);
    emit(state.copyWith(newPass: newPass, status: FormzSubmissionStatus.initial));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.newPass.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedNewPass: confirmedPassword,
        isValid: Formz.validate([
          state.newPass,
          confirmedPassword,
        ]),
      ),
    );
  }

  void viewOldPass() {
    emit(state.copyWith(viewOldPass: !state.viewOldPass));
  }

  void viewNewPass() {
    emit(state.copyWith(viewNewPass: !state.viewNewPass));
  }

  void viewConfirmedNewPass() {
    emit(state.copyWith(viewConfirmedNewPass: !state.viewConfirmedNewPass));
  }

  void changePassword() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final oldPass = base64Encode(utf8.encode(state.oldPass.value));
      final newPass = base64Encode(utf8.encode(state.newPass.value));
      await _userRepository.changePassword(oldPass: oldPass, newPass: newPass);

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
