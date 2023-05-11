import 'package:authentication_repository/authentication_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginState());

  final Authentication _authenticationRepository;

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(state.copyWith(
        emailInput: email, status: FormzSubmissionStatus.initial));
  }

  void passwordChanged(String value) {
    final pass = PasswordInput.dirty(value);
    emit(
        state.copyWith(passInput: pass, status: FormzSubmissionStatus.initial));
  }

  Future<void> authWithEmailAndPassword() async {
    debugPrint(state.status.name);
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository
          .authWithEmailAndPassword(AuthenticationParam(
        email: state.emailInput.value,
        pass: state.passInput.value,
      ));

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
