import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutsheetVideoCubit, WorkoutsheetVideoPageState>(
      builder: (context, state) {
        if (state.status == WorkoutsheetVideoPageStatus.loadInProgress) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == WorkoutsheetVideoPageStatus.loadSuccess) {
          final index = state.currentWorkoutIndex;

          return BlocProvider.value(
            value: context.read<WorkoutsheetVideoCubit>(),
            child: WorkoutsheetVideoScreen(
              workout: _workoutsheet.workouts[index],
              indexCurrentWorkoutVideo: state.currentWorkoutVideoIndex,
              nextButtonFunction: index + 1 == _workoutlength ? null : cubit.nextWorkout,
              previousButtonFunction: index > 0 ? cubit.previousWorkout : null,
              subTitle: _workoutsheet.workouts[index].subtitle,
              description: _workoutsheet.workouts[index].description,
              videoPlayerController: state.allWorkoutVideoModel[index].controllers,
              isCurrentVideoPlaying: state.currentVideoIsPlaying,
            ),
          );
        }

        return Container();
      },
    );
  }
}
