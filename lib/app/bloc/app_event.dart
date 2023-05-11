part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

// ignore: unused_element
class AppUserChanged extends AppEvent {
  const AppUserChanged(this.user);

  final UserAuthenticationModel user;
}
