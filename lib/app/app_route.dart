import 'package:amandaleme_personal_app/home/cubit/home_cubit.dart';
import 'package:amandaleme_personal_app/home/home.page.dart';
import 'package:amandaleme_personal_app/login/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

class RouteNames {
  static const String login = '/login';
  static const String home = '/home';
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
              RepositoryProvider.of<IWorkoutSheetRepository>(context),
            ),
            child: const HomePage(),
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
