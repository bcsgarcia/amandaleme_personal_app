import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:sync_repository/sync_repository.dart';

import '../app/app_route.dart';
import '../app/common_widgets/common_widgets.dart';
import '../home/cubit/home_cubit/home_cubit.dart';
import '../home/home.page.dart';
import 'cubit/workoutsheet_video_cubit.dart';
import 'screen/workoutsheet_video_screen.dart';

class WorkoutsheetVideoPage extends StatefulWidget {
  const WorkoutsheetVideoPage({
    super.key,
    required this.workoutsheet,
    this.startWorkoutIndex = 0,
  });

  final WorkoutSheetModel workoutsheet;
  final int startWorkoutIndex;

  @override
  State<WorkoutsheetVideoPage> createState() => _WorkoutsheetVideoPageState();
}

class _WorkoutsheetVideoPageState extends State<WorkoutsheetVideoPage> {
  WorkoutSheetModel get _workoutsheet => widget.workoutsheet;
  int get _startWorkoutIndex => widget.startWorkoutIndex;

  late int _workoutlength;
  late WorkoutsheetVideoCubit cubit;

  @override
  void initState() {
    super.initState();
    _workoutlength = _workoutsheet.workouts.length;
    cubit = context.read<WorkoutsheetVideoCubit>();
    cubit.initWorkoutVideoControllers(_workoutsheet, _startWorkoutIndex);
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialogWidget(
          title: 'Parabéns!',
          description: 'Estamos um passo mais perto de alcançar nossos objetivos. Nos vemos no próximo treino!',
          buttonLabel: 'Voltar à página inicial',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => HomeCubit(
                    homeRepository: RepositoryProvider.of<IHomeRepository>(context),
                    syncRepository: RepositoryProvider.of<SyncRepository>(context),
                  ),
                  child: HomePage(),
                ),
              ),
              ModalRoute.withName(RouteNames.home),
            );
          },
        );
      },
    );
  }

  void _showFailureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          buttonPressed: () {
            Navigator.of(context).pop();
            onCompleteWorkoutsheetTap();
          },
        );
      },
    );
  }

  onCompleteWorkoutsheetTap() {
    cubit.workoutsheetDone(_workoutsheet.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutsheetVideoCubit, WorkoutsheetVideoPageState>(
      listener: (context, state) {
        if (state.status == WorkoutsheetVideoPageStatus.loadSuccess) {
          _showSuccessDialog();
        }
        if (state.status == WorkoutsheetVideoPageStatus.loadFailure) {
          _showFailureDialog();
        }
      },
      child: BlocBuilder<WorkoutsheetVideoCubit, WorkoutsheetVideoPageState>(
        builder: (context, state) {
          if (state.status == WorkoutsheetVideoPageStatus.loadInProgress) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state.status == WorkoutsheetVideoPageStatus.allVideosPrepared || state.status == WorkoutsheetVideoPageStatus.loadSuccess) {
            final index = state.currentWorkoutIndex;

            return BlocProvider.value(
              value: context.read<WorkoutsheetVideoCubit>(),
              child: WorkoutsheetVideoScreen(
                workout: _workoutsheet.workouts[index],
                indexCurrentWorkoutVideo: state.currentWorkoutVideoIndex,
                nextButtonFunction: index + 1 == _workoutlength ? null : cubit.nextWorkout,
                previousButtonFunction: index > 0 ? cubit.previousWorkout : null,
                concludeWorkoutsheetFunction: index == _workoutlength - 1 ? onCompleteWorkoutsheetTap : null,
                subTitle: _workoutsheet.workouts[index].subtitle,
                description: _workoutsheet.workouts[index].description,
                videoPlayerController: state.allWorkoutVideoModel[index].controllers,
                isCurrentVideoPlaying: state.currentVideoIsPlaying,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
