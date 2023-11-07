part of 'workoutsheet_video_cubit.dart';

enum WorkoutsheetVideoPageStatus { initial, loadInProgress, loadSuccess, loadFailure, allVideosPrepared, notSync }

// ignore: must_be_immutable
class WorkoutsheetVideoPageState extends Equatable {
  WorkoutsheetVideoPageState({
    required this.status,
    required this.allWorkoutVideoModel,
    required this.currentWorkoutIndex,
    required this.currentWorkoutVideoIndex,
    this.videoDuration = Duration.zero,
    this.currentVideoIsPlaying = false,
  });

  final WorkoutsheetVideoPageStatus status;
  final List<VideoControllerModel> allWorkoutVideoModel;
  int currentWorkoutIndex;
  int currentWorkoutVideoIndex;
  bool currentVideoIsPlaying;
  Duration videoDuration;

  WorkoutsheetVideoPageState copyWith({
    WorkoutsheetVideoPageStatus? status,
    List<VideoControllerModel>? allWorkoutVideoModel,
    int? currentWorkoutIndex,
    int? currentWorkoutVideoIndex,
    bool? currentVideoIsPlaying,
    Duration? videoDuration,
  }) {
    return WorkoutsheetVideoPageState(
      status: status ?? this.status,
      allWorkoutVideoModel: allWorkoutVideoModel ?? this.allWorkoutVideoModel,
      currentWorkoutIndex: currentWorkoutIndex ?? this.currentWorkoutIndex,
      currentWorkoutVideoIndex: currentWorkoutVideoIndex ?? this.currentWorkoutVideoIndex,
      currentVideoIsPlaying: currentVideoIsPlaying ?? this.currentVideoIsPlaying,
      videoDuration: videoDuration ?? this.videoDuration,
    );
  }

  @override
  List<Object?> get props => [
        status,
        allWorkoutVideoModel,
        currentWorkoutIndex,
        currentVideoIsPlaying,
        currentWorkoutVideoIndex,
      ];
}
