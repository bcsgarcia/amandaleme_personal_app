part of 'app_bloc.dart';

enum AppStatus {
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

  final AppStatus status;
  final UserAuthenticationModel authentication;

  @override
  List<Object?> get props => [status, authentication];
}
