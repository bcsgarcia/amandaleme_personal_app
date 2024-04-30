import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'photo_drawer_state.dart';

class PhotoDrawerCubit extends Cubit<PhotoDrawerState> {
  PhotoDrawerCubit() : super(const PhotoDrawerState(status: PhotoDraweStatus.initial));

  void updatePhotoDrawer() async {
    emit(state.copyWith(status: PhotoDraweStatus.loadInProgress));
    emit(state.copyWith(status: PhotoDraweStatus.loadSuccess));
  }
}
