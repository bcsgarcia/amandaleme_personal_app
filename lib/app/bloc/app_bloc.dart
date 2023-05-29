import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required Authentication authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          // authenticationRepository.currentUser.isNotEmpty ? AppState.authenticated(authenticationRepository.currentUser) : const AppState.unauthenticated(),
          const AppState.initial(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppVerifyUser>(verifyUser);
    _userSubscription = _authenticationRepository.user.listen((user) {
      add(AppUserChanged(user));
    });
  }

  final Authentication _authenticationRepository;
  late final StreamSubscription<UserAuthenticationModel> _userSubscription;

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    emit(
      event.user.isNotEmpty ? AppState.authenticated(event.user) : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    _logout();
  }

  void verifyUser(
    AppVerifyUser event,
    Emitter<AppState> emit,
  ) async {
    try {
      final currentUser = _authenticationRepository.currentUser;

      final userHasLoggedBefore = currentUser.token.isNotEmpty;

      if (userHasLoggedBefore) {
        final result = await _authenticationRepository.requestLocalAuth();
        if (result == LocalAuthStatusEnum.failure || result == LocalAuthStatusEnum.errorDefault || result == LocalAuthStatusEnum.lockedOut) {
          _logout();
        }
      } else {
        emit(const AppState.unauthenticated());
      }
    } catch (_) {
      _logout();
    }
  }

  void _logout() {
    _authenticationRepository.logout();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
