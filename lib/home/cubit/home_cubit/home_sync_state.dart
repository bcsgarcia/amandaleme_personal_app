// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_sync_cubit.dart';

enum SyncStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
}

class HomeSyncState extends Equatable {
  const HomeSyncState(this.status);

  final SyncStatus status;

  @override
  List<Object?> get props => [status];

  HomeSyncState copyWith({
    SyncStatus? status,
  }) {
    return HomeSyncState(
      status ?? this.status,
    );
  }
}
