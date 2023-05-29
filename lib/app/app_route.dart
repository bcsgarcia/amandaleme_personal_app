import 'package:amandaleme_personal_app/app/screen/splash_screen.dart';
import 'package:amandaleme_personal_app/home/home.page.dart';
import 'package:amandaleme_personal_app/login/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:sync_repository/sync_repository.dart';

import '../home/cubit/home_cubit/home_cubit.dart';
import 'bloc/app_bloc.dart';

class RouteNames {
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeCubit(
              homeRepository: RepositoryProvider.of<IHomeRepository>(context),
              syncRepository: RepositoryProvider.of<SyncRepository>(context),
            ),
            child: HomePage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.initial:
      return [SplashScreen.page()];
  }
}
