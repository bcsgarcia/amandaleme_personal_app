part of 'workout_video_bloc.dart';

class WorkoutVideoPageState extends Equatable {
  const WorkoutVideoPageState({
    required this.currentVideoIndex,
    required this.isPlaying,
  });

  final int currentVideoIndex;
  final bool isPlaying;

  WorkoutVideoPageState copyWith({
    int? currentVideoIndex,
    bool? isPlaying,
  }) {
    return WorkoutVideoPageState(
      currentVideoIndex: currentVideoIndex ?? this.currentVideoIndex,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [currentVideoIndex, isPlaying];
}
