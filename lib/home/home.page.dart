import 'package:amandaleme_personal_app/home/cubit/feedback/feedback_cubit.dart';
import 'package:amandaleme_personal_app/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../app/common_widgets/common_widgets.dart';
import 'cubit/home_cubit/cubit.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.isShowFeedback = false,
  });

  static Page<void> page() => MaterialPage<void>(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeCubit(
                homeRepository: RepositoryProvider.of<IHomeRepository>(context),
              ),
            ),
          ],
          child: const HomePage(),
        ),
      );

  final bool isShowFeedback;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().getHomePage();
    context.read<SyncCubit>().shouldSync();
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
                      context.read<HomeCubit>().getHomePage();
                    },
                  );
                },
              );
            }

            // if (state.status == HomePageStatus.sync) {
            //   _goToSyncPage();
            // }
          },
          child: BlocBuilder<HomeCubit, HomePageState>(
            builder: (context, state) {
              // if (state.status == HomePageStatus.loadSuccess) {
              return BlocProvider(
                create: (_) => FeedbackCubit(context.read<WorkoutsheetRepository>()),
                child: HomeScreen(
                  // homeScreenModel: state.screenModel!,
                  showFeedbackWidget: widget.isShowFeedback,
                ),
              );
              // }

              // if (state.status == HomePageStatus.sync) {
              //   return const DownloadProgressPage();
              // }

              // return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
    });
  }
}
