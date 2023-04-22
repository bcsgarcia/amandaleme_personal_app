import 'package:amandaleme_personal_app/app/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/view/app.dart';
import 'factories/factories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  final localStorageAdapter =
      await CacheStorageFactory.makeLocalStorageAdapter();

  final authenticationRepository =
      makeAuthenticationRepositoryFactory(localStorageAdapter);
  authenticationRepository.user.first;

  runApp(App(
    authenticationRepository: authenticationRepository,
    companyRepository: makeCompanyRepositoryFactory(),
  ));
}
