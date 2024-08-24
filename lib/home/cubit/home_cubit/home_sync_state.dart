// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_sync_cubit.dart';

enum SyncStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
}

class HomeSyncState extends Equatable {
  const HomeSyncState(this.status, this.percentage);

  final SyncStatus status;
  final double percentage;

  @override
  List<Object?> get props => [status, percentage];

  HomeSyncState copyWith({
    SyncStatus? status,
    double? percentage,
  }) {
    return HomeSyncState(
      status ?? this.status,
      percentage ?? this.percentage,
    );
  }
}
