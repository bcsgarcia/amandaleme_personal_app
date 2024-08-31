import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpers/helpers.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../app/app.dart';
import 'factories/factories.dart';

Future<void> main() async {
  const environmentType = kDebugMode ? EnvironmentType.dev : EnvironmentType.prod;
  await Environment.loadDotEnv(environmentType);

  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    Bloc.observer = const AppBlocObserver();
  }

  initializeDateFormatting('pt_BR', null);

  final localStorageAdapter = await CacheStorageFactory.makeLocalStorageAdapter();
  final authenticationRepository = makeAuthenticationRepositoryFactory(localStorageAdapter);
  authenticationRepository.user.first;

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      companyRepository: makeCompanyRepositoryFactory(Environment.companyId),
      homeRepository: makeHomeRepositoryFactory(localStorageAdapter),
      notificationRepository: makeNotificationRepositoryFactory(localStorageAdapter),
      syncRepository: makeSyncRepositoryFactory(localStorageAdapter),
      workoutsheetRepository: makeWorkoutsheetRepositoryFactory(localStorageAdapter),
      userRepository: makeUserRepositoryFactory(localStorageAdapter),
      workoutRepository: makeWorkoutRepositoryFactory(localStorageAdapter),
    ),
  );
}
