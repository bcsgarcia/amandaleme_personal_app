import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:amandaleme_personal_app/home/home.page.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:company_repository/company_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../login/view.dart';
import '../bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required Authentication authenticationRepository,
    required CompanyRepository companyRepository,
  })  : _authenticationRepository = authenticationRepository,
        _companyRepository = companyRepository;

  final Authentication _authenticationRepository;
  final CompanyRepository _companyRepository;

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
      return '/login';
    } else {
      return '/login';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      initialRoute: initialRoute(context),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}
