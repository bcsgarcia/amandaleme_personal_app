import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:video_preparation_service/video_preparation_service.dart';

import '../../lib.dart';

class App extends StatelessWidget {
  App({
    super.key,
    required Authentication authenticationRepository,
    required CompanyRepository companyRepository,
    required IHomeRepository homeRepository,
    required NotificationRepository notificationRepository,
    required SyncRepository syncRepository,
    required WorkoutsheetRepository workoutsheetRepository,
    required UserRepository userRepository,
    required WorkoutRepository workoutRepository,
  })  : _authenticationRepository = authenticationRepository,
        _companyRepository = companyRepository,
        _iHomeRepository = homeRepository,
        _notificationRepository = notificationRepository,
        _syncRepository = syncRepository,
        _workoutsheetRepository = workoutsheetRepository,
        _userRepository = userRepository,
        _workoutRepository = workoutRepository;

  final Authentication _authenticationRepository;
  final CompanyRepository _companyRepository;
  final IHomeRepository _iHomeRepository;
  final NotificationRepository _notificationRepository;
  final SyncRepository _syncRepository;
  final WorkoutsheetRepository _workoutsheetRepository;
  final UserRepository _userRepository;
  final WorkoutRepository _workoutRepository;

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
          ),
          RepositoryProvider.value(
            value: _userRepository,
          ),
          RepositoryProvider.value(
            value: _workoutRepository,
          )
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AppBloc(
                authenticationRepository: _authenticationRepository,
                syncRepository: _syncRepository,
              ),
            ),
            BlocProvider(
              create: (_) => HomeSyncCubit(_syncRepository),
            ),
            BlocProvider(
              create: (_) => MeetAppCubit(
                _companyRepository,
              ),
            ),
            BlocProvider(
              create: (_) => PhotoDrawerCubit(),
            ),
          ],
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.status == AppStatus.initial) {
            return const SplashScreen();
          } else if (state.status == AppStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HomeCubit(
                    homeRepository: RepositoryProvider.of<IHomeRepository>(context),
                  ),
                ),
              ],
              child: const HomePage(),
            );
          } else if (state.status == AppStatus.unauthenticated) {
            return const LoginPage();
          } else {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${state.status}'),
              ),
            );
          }
        },
      ),

      // FlowBuilder<AppStatus>(
      //   state: context.select((AppBloc bloc) => bloc.state.status),
      //   onGeneratePages: onGenerateAppViewPages,
      // ),
    );
  }
}
