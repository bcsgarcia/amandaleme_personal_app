part of 'notification_cubit.dart';

enum NotificationPageStatus {
  initial,
  loadInProgress,
  loadSuccess,
  loadFailure,
}

class NotificationPageState extends Equatable {
  const NotificationPageState(this.status);

  final NotificationPageStatus status;

  NotificationPageState copyWith(NotificationPageStatus? status) {
    return NotificationPageState(status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
