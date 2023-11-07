// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sync_cubit.dart';

enum SyncStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
}

class SyncState extends Equatable {
  const SyncState(this.status);

  final SyncStatus status;

  @override
  List<Object?> get props => [status];

  SyncState copyWith({
    SyncStatus? status,
  }) {
    return SyncState(
      status ?? this.status,
    );
  }
}
