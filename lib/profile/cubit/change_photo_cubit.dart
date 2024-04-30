import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'change_photo_state.dart';

class ChangePhotoCubit extends Cubit<ChangePhotoState> {
  ChangePhotoCubit({
    required this.userRepository,
  }) : super(const ChangePhotoState(status: ChangePhotoStatusEnum.initial));

  final UserRepository userRepository;

  Future<void> uploadPhoto(File photo) async {
    try {
      emit(state.copyWith(status: ChangePhotoStatusEnum.inProgress));

      Uint8List photoByte = await photo.readAsBytes();

      await userRepository.uploadPhoto(photoByte);

      emit(state.copyWith(status: ChangePhotoStatusEnum.success));
    } catch (e) {
      emit(state.copyWith(status: ChangePhotoStatusEnum.failure));
    }
  }
}
