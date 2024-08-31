// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginState());

  final Authentication _authenticationRepository;

  void emailChanged(String value) {
    final email = EmailInput.dirty(value.trim());
    emit(state.copyWith(emailInput: email, status: FormzSubmissionStatus.initial));
  }

  void passwordChanged(String value) {
    final pass = PasswordInput.dirty(value);
    emit(state.copyWith(passInput: pass, status: FormzSubmissionStatus.initial));
  }

  void keepConnectedTap() {
    emit(state.copyWith(keepConnected: !state.keepConnected));
  }

  Future<void> authWithEmailAndPassword() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.authWithEmailAndPassword(
        AuthenticationParam(
          email: state.emailInput.value.trim(),
          pass: state.passInput.value,
        ),
        keepConnected: state.keepConnected,
      );

      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
