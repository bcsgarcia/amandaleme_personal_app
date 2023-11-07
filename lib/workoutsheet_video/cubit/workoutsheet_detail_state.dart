// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'workoutsheet_detail_cubit.dart';

enum VideoAction {
  play,
  pause,
  stop,
  next,
  nextVideo,
  previous,
  previousVideo,
}

class WorkoutsheetDetailState extends Equatable {
  const WorkoutsheetDetailState({
    required this.allWorkoutVideoModel,
    required this.currentWorkoutVideoIndex,
    required this.videoAction,
    required this.workout,
    required this.workoutsheet,
    required this.currentVideoFile,
    required this.isFirstWorkout,
    required this.isLastWorkout,
    required this.progress,
  });

  final List<VideoControllerModel> allWorkoutVideoModel;
  final int currentWorkoutVideoIndex;
  final VideoAction videoAction;
  final WorkoutModel workout;
  final WorkoutSheetModel workoutsheet;
  final File currentVideoFile;
  final bool isFirstWorkout;
  final bool isLastWorkout;
  final double progress;

  @override
  List<Object?> get props => [
        allWorkoutVideoModel,
        currentWorkoutVideoIndex,
        videoAction,
        workout,
        workoutsheet,
        currentVideoFile,
        isFirstWorkout,
        isLastWorkout,
        progress,
      ];

  WorkoutsheetDetailState copyWith({
    List<VideoControllerModel>? allWorkoutVideoModel,
    int? currentWorkoutVideoIndex,
    VideoAction? videoAction,
    WorkoutModel? workout,
    WorkoutSheetModel? workoutsheet,
    File? currentVideoFile,
    bool? isFirstWorkout,
    bool? isLastWorkout,
    double? progress,
  }) {
    return WorkoutsheetDetailState(
      allWorkoutVideoModel: allWorkoutVideoModel ?? this.allWorkoutVideoModel,
      currentWorkoutVideoIndex: currentWorkoutVideoIndex ?? this.currentWorkoutVideoIndex,
      videoAction: videoAction ?? this.videoAction,
      workout: workout ?? this.workout,
      workoutsheet: workoutsheet ?? this.workoutsheet,
      currentVideoFile: currentVideoFile ?? this.currentVideoFile,
      isFirstWorkout: isFirstWorkout ?? this.isFirstWorkout,
      isLastWorkout: isLastWorkout ?? this.isLastWorkout,
      progress: progress ?? this.progress,
    );
  }
}
