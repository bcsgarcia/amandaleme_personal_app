part of 'workoutsheet_video_cubit.dart';

enum WorkoutsheetVideoPageStatus {
  initial,
  loadInProgress,
  loadSuccess,
  loadFailure,
}

class WorkoutsheetVideoPageState extends Equatable {
  const WorkoutsheetVideoPageState({
    required this.status,
  });

  final WorkoutsheetVideoPageStatus status;

  WorkoutsheetVideoPageState copyWith({
    WorkoutsheetVideoPageStatus? status,
  }) {
    return WorkoutsheetVideoPageState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
