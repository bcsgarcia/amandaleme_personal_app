import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_repository/home_repository.dart';
import 'package:video_preparation_service/video_preparation_service.dart';

part 'workoutsheet_video_state.dart';

class WorkoutsheetVideoCubit extends Cubit<WorkoutsheetVideoPageState> {
  WorkoutsheetVideoCubit(
    this.videoPreparationService,
  ) : super(
          WorkoutsheetVideoPageState(
            status: WorkoutsheetVideoPageStatus.initial,
            allWorkoutVideoModel: const [],
            currentWorkoutIndex: 0,
            currentWorkoutVideoIndex: 0,
          ),
        );

  final VideoPreparationService videoPreparationService;

  List<String> filesPaths = [];

  void initWorkoutVideoControllers(WorkoutSheetModel workoutSheet, int startIndex) async {
    emit(state.copyWith(status: WorkoutsheetVideoPageStatus.loadInProgress));

    final allWorkoutVideoModel = await videoPreparationService.prepareVideos(workoutSheet.workouts);

    emit(
      state.copyWith(
        status: WorkoutsheetVideoPageStatus.loadSuccess,
        allWorkoutVideoModel: allWorkoutVideoModel,
        currentWorkoutIndex: startIndex,
        currentWorkoutVideoIndex: 0,
      ),
    );
  }

  void updateIndexVideoWorkout(int index) {
    emit(state.copyWith(currentWorkoutVideoIndex: index));
  }

  void nextWorkout() {
    int currentWorkout = state.currentWorkoutIndex;
    int currentWorkoutVideo = state.currentWorkoutVideoIndex;

    state.allWorkoutVideoModel[currentWorkout].controllers[currentWorkoutVideo].seekTo(Duration.zero);
    state.allWorkoutVideoModel[currentWorkout].controllers[currentWorkoutVideo].pause();

    resetAllVideosOfWorkout();

    emit(state.copyWith(
      currentWorkoutIndex: currentWorkout + 1,
      currentWorkoutVideoIndex: 0,
      currentVideoIsPlaying: false,
    ));
  }

  void previousWorkout() {
    int currentWorkout = state.currentWorkoutIndex;
    int currentWorkoutVideo = state.currentWorkoutVideoIndex;

    state.allWorkoutVideoModel[currentWorkout].controllers[currentWorkoutVideo].seekTo(Duration.zero);
    state.allWorkoutVideoModel[currentWorkout].controllers[currentWorkoutVideo].pause();

    resetAllVideosOfWorkout();

    emit(state.copyWith(
      currentWorkoutIndex: currentWorkout - 1,
      currentWorkoutVideoIndex: 0,
      currentVideoIsPlaying: false,
    ));
  }

  void playCurrentVideo() {
    int currentWorkout = state.currentWorkoutIndex;
    int currentWorkoutVideo = state.currentWorkoutVideoIndex;

    state.allWorkoutVideoModel[currentWorkout].controllers[currentWorkoutVideo].play();

    emit(state.copyWith(currentVideoIsPlaying: true));
  }

  void pauseCurrentVideo() {
    int currentWorkout = state.currentWorkoutIndex;
    int currentWorkoutVideo = state.currentWorkoutVideoIndex;

    state.allWorkoutVideoModel[currentWorkout].controllers[currentWorkoutVideo].pause();
    emit(state.copyWith(currentVideoIsPlaying: false));
  }

  Future<void> playNextVideoOfTheCurrentWorkout() async {
    final currentVideo = state.allWorkoutVideoModel[state.currentWorkoutIndex].controllers[state.currentWorkoutVideoIndex];
    final currentVideoIndex = state.currentWorkoutVideoIndex;

    final thereAreMoreVideo = state.currentWorkoutVideoIndex < state.allWorkoutVideoModel[state.currentWorkoutIndex].controllers.length - 1;

    final allVideosOfTheWorkout = state.allWorkoutVideoModel[state.currentWorkoutIndex].controllers;

    final nextVideoIndex = state.currentWorkoutVideoIndex + 1;

    if (currentVideoIndex == 0 && thereAreMoreVideo == false) {
      return;
    } else {
      if (currentVideo.value.isPlaying && thereAreMoreVideo) {
        currentVideo.seekTo(currentVideo.value.duration);
        currentVideo.pause();

        allVideosOfTheWorkout[nextVideoIndex].play();

        emit(state.copyWith(
          currentWorkoutVideoIndex: nextVideoIndex,
        ));
      } else if (currentVideo.value.isPlaying && currentVideoIndex == allVideosOfTheWorkout.length - 1 && currentVideoIndex > 0) {
        resetAllVideosOfWorkout();
        pauseAllVideosOfWorkout();
        emit(state.copyWith(
          currentVideoIsPlaying: false,
          currentWorkoutVideoIndex: 0,
        ));
      }
    }
  }

  void playPreviousVideoOfTheCurrentWOrkout() {
    final currentVideo = state.allWorkoutVideoModel[state.currentWorkoutIndex].controllers[state.currentWorkoutVideoIndex];

    final thereAreMoreVideo = state.currentWorkoutVideoIndex < state.allWorkoutVideoModel[state.currentWorkoutIndex].controllers.length - 1;

    final currentVideoIndex = state.currentWorkoutVideoIndex;
    final previusVIdeoIndex = currentVideoIndex - 1;

    if (currentVideoIndex == 0 && thereAreMoreVideo == false) {
      return;
    } else {
      if (currentVideo.value.isPlaying) {
        currentVideo.seekTo(Duration.zero);

        if (state.allWorkoutVideoModel[state.currentWorkoutIndex].controllers.length - 1 > 0) {
          final previousVideo = state.allWorkoutVideoModel[state.currentWorkoutIndex].controllers[state.currentWorkoutVideoIndex - 1];

          currentVideo.pause();

          previousVideo.seekTo(Duration.zero);
          previousVideo.play();

          emit(
            state.copyWith(currentWorkoutVideoIndex: previusVIdeoIndex),
          );
        }
      }
    }
  }

  Future<void> pauseAllVideosOfWorkout() async {
    final allWorkoutControllers = state.allWorkoutVideoModel[state.currentWorkoutIndex];

    for (var controller in allWorkoutControllers.controllers) {
      await controller.pause();
    }
  }

  Future<void> resetAllVideosOfWorkout() async {
    final allWorkoutControllers = state.allWorkoutVideoModel[state.currentWorkoutIndex];

    for (var controller in allWorkoutControllers.controllers) {
      await controller.seekTo(const Duration(seconds: 0));
      await controller.pause();
    }
  }

  void updatePageState(int currentVideoIndex, bool isPlaying) {
    emit(state.copyWith(
      currentWorkoutVideoIndex: currentVideoIndex,
      currentVideoIsPlaying: isPlaying,
    ));
  }

  @override
  Future<void> close() async {
    for (var model in state.allWorkoutVideoModel) {
      for (var controller in model.controllers) {
        await controller.dispose();
      }
    }

    await super.close();
  }
}
