part of 'feedback_cubit.dart';

enum FeedbackStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
}

class FeedbackState extends Equatable {
  const FeedbackState({
    required this.status,
  });

  final FeedbackStatus status;

  FeedbackState copyWith({
    FeedbackStatus? status,
  }) {
    return FeedbackState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
