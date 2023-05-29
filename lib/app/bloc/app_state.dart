part of 'app_bloc.dart';

enum AppStatus {
  initial,
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState._({
    required this.status,
    this.authentication = UserAuthenticationModel.empty,
  });

  const AppState.authenticated(UserAuthenticationModel authentication) : this._(status: AppStatus.authenticated, authentication: authentication);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AppState.initial() : this._(status: AppStatus.initial);

  final AppStatus status;
  final UserAuthenticationModel authentication;

  @override
  List<Object?> get props => [status, authentication];
}
