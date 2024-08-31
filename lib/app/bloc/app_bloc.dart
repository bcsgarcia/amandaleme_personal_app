import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required Authentication authenticationRepository,
    required this.syncRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
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
  final SyncRepository syncRepository;

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    final appState = event.user.isNotEmpty ? AppState.authenticated(event.user) : const AppState.unauthenticated();
    emit(appState);
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
        if (result == LocalAuthStatusEnum.failure ||
            result == LocalAuthStatusEnum.errorDefault ||
            result == LocalAuthStatusEnum.lockedOut) {
          _logout();
        } else {
          emit(AppState.authenticated(currentUser));
        }
      } else {
        _logout();
      }
    } catch (error, stacktrace) {
      // debugPrint('${error.toString()}\n${stacktrace.toString()}');
      _logout();
    }
  }

  void _logout() {
    syncRepository.removeAllData();
    _authenticationRepository.logout();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
