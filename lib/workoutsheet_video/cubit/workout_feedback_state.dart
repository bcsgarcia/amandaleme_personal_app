part of 'workout_feedback_cubit.dart';

enum WorkoutFeedbackStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
}

class WorkoutFeedbackState extends Equatable {
  const WorkoutFeedbackState({
    this.status = WorkoutFeedbackStatus.initial,
  });

  final WorkoutFeedbackStatus status;

  WorkoutFeedbackState copyWith({
    WorkoutFeedbackStatus? status,
  }) {
    return WorkoutFeedbackState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
