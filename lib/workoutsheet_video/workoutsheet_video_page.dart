import 'package:amandaleme_personal_app/workoutsheet_video/screen/screen.dart';
import 'package:amandaleme_personal_app/workoutsheet_video/utils/workoutsheet_video_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';

import 'cubit/workoutsheet_video_cubit.dart';

class WorkoutsheetVideoPage extends StatefulWidget {
  const WorkoutsheetVideoPage({
    super.key,
    required this.workoutsheet,
  });

  final WorkoutSheetModel workoutsheet;

  @override
  State<WorkoutsheetVideoPage> createState() => _WorkoutsheetVideoPageState();
}

class _WorkoutsheetVideoPageState extends State<WorkoutsheetVideoPage> {
  WorkoutSheetModel get _workoutsheet => widget.workoutsheet;

  List<VideoControllerModel> controllers = [];

  late int _workoutlength;
  late WorkoutsheetVideoCubit cubit;

  int _index = 0;

  void _nextWorkout() {
    _index++;
    setState(() {});
  }

  void _previousWorkout() {
    _index--;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _workoutlength = _workoutsheet.workouts.length;
    cubit = context.read<WorkoutsheetVideoCubit>();
    controllers = cubit.videoPreparationService.controllers;
    cubit.prepareVideoPlayerControllers(_workoutsheet);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.controller.dispose();
    }
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
          return WorkoutsheetVideoScreen(
            workout: _workoutsheet.workouts[_index],
            nextButtonFunction: _index + 1 == _workoutlength ? null : _nextWorkout,
            previousButtonFunction: _index > 0 ? _previousWorkout : null,
            isShowPlay: _workoutsheet.workouts[_index].videoUrl.isNotEmpty,
            subTitle: _workoutsheet.workouts[_index].subtitle,
            description: _workoutsheet.workouts[_index].description,
            videoPlayerController: controllers.firstWhere((element) => element.idWorkout == _workoutsheet.workouts[_index].id).controller,
          );
        }

        return Container();
      },
    );
  }
}
