import 'package:amandaleme_personal_app/home/cubit/feedback/feedback_cubit.dart';
import 'package:amandaleme_personal_app/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:sync_repository/sync_repository.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../app/common_widgets/common_widgets.dart';
import 'cubit/home_cubit/home_cubit.dart';
import 'screen/sync_page.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    this.isShowFeedback = false,
  });

  static Page<void> page() => MaterialPage<void>(
        child: BlocProvider(
          create: (context) => HomeCubit(
            homeRepository: RepositoryProvider.of<IHomeRepository>(context),
            syncRepository: RepositoryProvider.of<SyncRepository>(context),
          ),
          child: HomePage(),
        ),
      );

  final bool isShowFeedback;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = context.read<HomeCubit>();
    _homeCubit.getHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: BlocListener<HomeCubit, HomePageState>(
          listener: (context, state) {
            if (state.status == HomePageStatus.failure) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    buttonPressed: () {
                      Navigator.of(context).pop();
                      _homeCubit.getHomePage();
                    },
                  );
                },
              );
            }
          },
          child: BlocBuilder<HomeCubit, HomePageState>(
            builder: (context, state) {
              if (state.status == HomePageStatus.loadSuccess) {
                return BlocProvider(
                  create: (_) => FeedbackCubit(context.read<WorkoutsheetRepository>()),
                  child: HomeScreen(
                    homeScreenModel: state.screenModel!,
                    showFeedbackWidget: widget.isShowFeedback,
                  ),
                );
              }

              if (state.status == HomePageStatus.sync) {
                return BlocProvider(
                  create: (_) => context.read<HomeCubit>(),
                  child: const DownloadProgressPage(),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
    });
  }
}
