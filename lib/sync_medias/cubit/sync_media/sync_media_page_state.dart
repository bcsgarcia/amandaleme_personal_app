part of 'sync_media_page_cubit.dart';

enum SyncPageStatus {
  initial,
  loadInProgress,
  loadSuccess,
  loadFailure,
  makeDownloadLater,
  unautorized,
}

class SyncMadiaPageState extends Equatable {
  const SyncMadiaPageState({
    required this.status,
  });

  final SyncPageStatus status;

  SyncMadiaPageState copyWith({
    SyncPageStatus? status,
  }) =>
      SyncMadiaPageState(status: status ?? this.status);

  @override
  List<Object?> get props => [status];
}
