import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:video_preparation_service/video_preparation_service.dart';

part 'workoutsheet_detail_state.dart';

class WorkoutsheetDetailCubit extends Cubit<WorkoutsheetDetailState> {
  WorkoutsheetDetailCubit({
    required this.videoPreparationService,
    required this.workoutsheetRepository,
    required List<VideoControllerModel> allWorkoutVideoModel,
    required File currentVideoFile,
    required WorkoutModel workout,
    required WorkoutSheetModel workoutsheet,
  }) : super(WorkoutsheetDetailState(
          allWorkoutVideoModel: allWorkoutVideoModel,
          currentWorkoutVideoIndex: 0,
          videoAction: VideoAction.pause,
          workout: workout,
          workoutsheet: workoutsheet,
          currentVideoFile: currentVideoFile,
          isFirstWorkout: workoutsheet.workouts.indexOf(workout) == 0,
          isLastWorkout: workoutsheet.workouts.indexOf(workout) == workoutsheet.workouts.length - 1,
          progress: 0,
        ));

  final VideoPreparationService videoPreparationService;
  final WorkoutsheetRepository workoutsheetRepository;

  void initialize() {
    final workoutIndex = state.workoutsheet.workouts.indexOf(state.workout);

    print(state.workoutsheet.workouts.length - 1 == workoutIndex);

    // emit(state.copyWith(isFirstWorkout: workoutIndex == 0, isLastWorkout: ))
  }

  void onPause() {
    emit(state.copyWith(videoAction: VideoAction.pause));
  }

  void onNextWorkout() {
    final currentWorkout = state.workout;
    final currentIndex = state.workoutsheet.workouts.indexOf(currentWorkout);

    final nextWorkout = state.workoutsheet.workouts[currentIndex + 1];
    final nextVideoFile = state.allWorkoutVideoModel[currentIndex + 1].mediaFileList.first;

    emit(
      state.copyWith(
        workout: nextWorkout,
        currentVideoFile: nextVideoFile,
        currentWorkoutVideoIndex: 0,
        videoAction: VideoAction.next,
        isFirstWorkout: state.workoutsheet.workouts.indexOf(nextWorkout) == 0,
        isLastWorkout: state.workoutsheet.workouts.indexOf(nextWorkout) == state.workoutsheet.workouts.length - 1,
        progress: 0,
      ),
    );
  }

  void onPreviousWorkout() {
    final currentWorkout = state.workout;
    final currentIndex = state.workoutsheet.workouts.indexOf(currentWorkout);

    final previousWorkout = state.workoutsheet.workouts[currentIndex - 1];
    final previousVideoFile = state.allWorkoutVideoModel[currentIndex - 1].mediaFileList.first;

    emit(
      state.copyWith(
        workout: previousWorkout,
        currentVideoFile: previousVideoFile,
        currentWorkoutVideoIndex: 0,
        videoAction: VideoAction.next,
        isFirstWorkout: state.workoutsheet.workouts.indexOf(previousWorkout) == 0,
        isLastWorkout: state.workoutsheet.workouts.indexOf(previousWorkout) == state.workoutsheet.workouts.length - 1,
        progress: 0,
      ),
    );
  }

  void onNextWorkoutVideo() {
    final workoutVideoModel = state.allWorkoutVideoModel.firstWhere((element) => element.idWorkout == state.workout.id);
    print('checkIfVideoHasEnded: 1');
    if (workoutVideoModel.mediaFileList.length <= 1) {
      print('checkIfVideoHasEnded: SAIU');
      return;
    }
    print('checkIfVideoHasEnded: 2');
    if (state.currentWorkoutVideoIndex == workoutVideoModel.mediaFileList.length - 1) {
      print('checkIfVideoHasEnded: SAIU');
      return;
    }
    print('checkIfVideoHasEnded: 3');
    emit(
      state.copyWith(
        currentWorkoutVideoIndex: state.currentWorkoutVideoIndex + 1,
        currentVideoFile: workoutVideoModel.mediaFileList[state.currentWorkoutVideoIndex + 1],
        videoAction: VideoAction.nextVideo,
        progress: 0,
      ),
    );
  }

  void shouldPlayNextVideo() {
    onNextWorkoutVideo();
  }

  void onPreviousWorkoutVideo() {
    final workoutVideoModel = state.allWorkoutVideoModel.firstWhere((element) => element.idWorkout == state.workout.id);

    if (workoutVideoModel.mediaFileList.length <= 1) {
      return;
    }

    if (state.currentWorkoutVideoIndex == 0) {
      return;
    }

    emit(
      state.copyWith(
        currentWorkoutVideoIndex: state.currentWorkoutVideoIndex - 1,
        currentVideoFile: workoutVideoModel.mediaFileList[state.currentWorkoutVideoIndex - 1],
        videoAction: VideoAction.previousVideo,
        progress: 0,
      ),
    );
  }

  void updateProgress(double progress) {
    print('checkIfVideoHasEnded: PROGRESS - $progress');
    emit(state.copyWith(
      progress: progress,
      videoAction: VideoAction.play,
    ));
  }

  void onDispose() {}
}
