import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:company_repository/company_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:sync_repository/sync_repository.dart';
import 'package:video_preparation_service/video_preparation_service.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../app_route.dart';
import '../bloc/app_bloc.dart';

class App extends StatelessWidget {
  App({
    super.key,
    required Authentication authenticationRepository,
    required CompanyRepository companyRepository,
    required IHomeRepository homeRepository,
    required NotificationRepository notificationRepository,
    required SyncRepository syncRepository,
    required WorkoutsheetRepository workoutsheetRepository,
  })  : _authenticationRepository = authenticationRepository,
        _companyRepository = companyRepository,
        _iHomeRepository = homeRepository,
        _notificationRepository = notificationRepository,
        _syncRepository = syncRepository,
        _workoutsheetRepository = workoutsheetRepository;

  final Authentication _authenticationRepository;
  final CompanyRepository _companyRepository;
  final IHomeRepository _iHomeRepository;
  final NotificationRepository _notificationRepository;
  final SyncRepository _syncRepository;
  final WorkoutsheetRepository _workoutsheetRepository;

  final VideoPreparationService _videoPreparationService = VideoPreparationService();

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
          value: _iHomeRepository,
        ),
        RepositoryProvider.value(
          value: _notificationRepository,
        ),
        RepositoryProvider.value(
          value: _videoPreparationService,
        ),
        RepositoryProvider.value(
          value: _syncRepository,
        ),
        RepositoryProvider.value(
          value: _workoutsheetRepository,
        )
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
