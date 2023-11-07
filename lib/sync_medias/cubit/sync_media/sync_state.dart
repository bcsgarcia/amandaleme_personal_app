part of 'sync_cubit.dart';

enum SyncPageStatus {
  initial,
  loadInProgress,
  loadSuccess,
  loadFailure,
  makeDownloadLater,
  unautorized,
}

class SyncPageState extends Equatable {
  const SyncPageState({
    required this.status,
  });

  final SyncPageStatus status;

  SyncPageState copyWith({
    SyncPageStatus? status,
  }) =>
      SyncPageState(status: status ?? this.status);

  @override
  List<Object?> get props => [status];
}
