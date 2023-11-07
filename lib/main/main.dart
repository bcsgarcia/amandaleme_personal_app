import 'package:amandaleme_personal_app/app/bloc_observer.dart';
import 'package:amandaleme_personal_app/main/factories/notification_repository/notification_repository_factory.dart';
import 'package:amandaleme_personal_app/main/factories/sync_repository/sync_repository_factory.dart';
import 'package:amandaleme_personal_app/main/factories/workout_repository/workout_repository_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../app/screen/app.dart';
import 'factories/factories.dart';

Future<void> main() async {
  const environmentType = !kDebugMode ? EnvironmentType.dev : EnvironmentType.prod;
  await Environment.loadDotEnv(EnvironmentType.prod);

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

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
