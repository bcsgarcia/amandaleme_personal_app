// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'change_photo_cubit.dart';

enum ChangePhotoStatusEnum {
  initial,
  inProgress,
  success,
  failure,
}

class ChangePhotoState extends Equatable {
  const ChangePhotoState({
    required this.status,
    this.uploadedPhoto,
  });

  final File? uploadedPhoto;
  final ChangePhotoStatusEnum status;

  ChangePhotoState copyWith({
    ChangePhotoStatusEnum? status,
    File? uploadedPhoto,
  }) {
    return ChangePhotoState(
      status: status ?? this.status,
      uploadedPhoto: uploadedPhoto,
    );
  }

  @override
  List<Object?> get props => [
        status,
        uploadedPhoto,
      ];
}
