// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'notifications_state.dart';

class NotificationCubit extends Cubit<NotificationPageState> {
  NotificationCubit(this.notificationRepository)
      : super(
          const NotificationPageState(NotificationPageStatus.initial),
        );

  final NotificationRepository notificationRepository;

  Future<void> updateUnreadNotification() async {
    try {
      emit(state.copyWith(NotificationPageStatus.loadInProgress));
      await notificationRepository.updateReadDateNotification();
      emit(state.copyWith(NotificationPageStatus.loadSuccess));
    } catch (e) {
      emit(state.copyWith(NotificationPageStatus.loadFailure));
    }
  }
}
