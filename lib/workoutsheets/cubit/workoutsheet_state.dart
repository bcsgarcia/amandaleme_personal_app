part of 'workoutsheet_cubit.dart';

enum WorkoutsheetPageStatus {
  initial,
  complete,
  incomplete,
  loadInProgress,
  loadFailure,
  loadSuccess,
}

class WorkoutsheetPageState extends Equatable {
  const WorkoutsheetPageState({
    required this.status,
  });

  final WorkoutsheetPageStatus status;

  WorkoutsheetPageState copyWith({
    WorkoutsheetPageStatus? status,
  }) {
    return WorkoutsheetPageState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
