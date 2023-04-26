import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../app_route.dart';
import '../bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required Authentication authenticationRepository,
    required CompanyRepository companyRepository,
    required IWorkoutSheetRepository iWorkoutSheetRepository,
  })  : _authenticationRepository = authenticationRepository,
        _companyRepository = companyRepository,
        _iWorkoutSheetRepository = iWorkoutSheetRepository;

  final Authentication _authenticationRepository;
  final CompanyRepository _companyRepository;
  final IWorkoutSheetRepository _iWorkoutSheetRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _companyRepository,
        ),
        RepositoryProvider.value(
          value: _iWorkoutSheetRepository,
        ),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  String? initialRoute(BuildContext context) {
    if (context.read<AppBloc>().state.status == AppStatus.authenticated) {
      return '/home';
    } else {
      return '/login';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: initialRoute(context),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
