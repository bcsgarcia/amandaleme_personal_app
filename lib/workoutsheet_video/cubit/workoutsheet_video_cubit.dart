// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:repositories/repositories.dart';
import 'package:video_preparation_service/video_preparation_service.dart';

part 'workoutsheet_video_state.dart';

class WorkoutsheetVideoCubit extends Cubit<WorkoutsheetVideoPageState> {
  WorkoutsheetVideoCubit({
    required this.videoPreparationService,
    required this.workoutsheetRepository,
  }) : super(
          WorkoutsheetVideoPageState(
            status: WorkoutsheetVideoPageStatus.initial,
            allWorkoutVideoModel: const [],
            currentWorkoutIndex: 0,
            currentWorkoutVideoIndex: 0,
          ),
        );

  final VideoPreparationService videoPreparationService;
  final WorkoutsheetRepository workoutsheetRepository;

  List<String> filesPaths = [];

  void initWorkoutVideoControllers(WorkoutSheetModel workoutSheet, int startIndex) async {
    try {
      emit(state.copyWith(
        status: WorkoutsheetVideoPageStatus.loadInProgress,
        allWorkoutVideoModel: [],
      ));

      final allWorkoutVideoModel = await videoPreparationService.prepareVideos(workoutSheet.workouts);

      emit(
        state.copyWith(
          status: WorkoutsheetVideoPageStatus.allVideosPrepared,
          allWorkoutVideoModel: allWorkoutVideoModel,
          currentWorkoutIndex: startIndex,
          currentWorkoutVideoIndex: 0,
        ),
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> workoutsheetDone(String idWorkoutsheet) async {
    try {
      emit(state.copyWith(status: WorkoutsheetVideoPageStatus.loadInProgress));
      await workoutsheetRepository.done(idWorkoutsheet);

      emit(state.copyWith(status: WorkoutsheetVideoPageStatus.loadSuccess));
    } catch (e) {
      emit(state.copyWith(status: WorkoutsheetVideoPageStatus.loadFailure));
    }
  }

  void onDisposeVideos() {
    emit(state.copyWith(
      allWorkoutVideoModel: [],
    ));
  }
}
