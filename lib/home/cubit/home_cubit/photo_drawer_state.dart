part of 'photo_drawer_cubit.dart';

enum PhotoDraweStatus {
  initial,
  loadInProgress,
  loadSuccess,
  failure,
}

class PhotoDrawerState extends Equatable {
  const PhotoDrawerState({
    required this.status,
  });

  final PhotoDraweStatus status;

  PhotoDrawerState copyWith({
    PhotoDraweStatus? status,
  }) {
    return PhotoDrawerState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
