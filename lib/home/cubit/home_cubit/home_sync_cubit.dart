// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

part 'home_sync_state.dart';

class HomeSyncCubit extends Cubit<HomeSyncState> {
  HomeSyncCubit(this.syncRepository) : super(const HomeSyncState(SyncStatus.initial, 0)) {
    syncRepository.downloadProgressStream.listen((percentage) {
      emit(state.copyWith(status: SyncStatus.loadInProgress, percentage: percentage));
      if (percentage == 1) {
        emit(state.copyWith(status: SyncStatus.loadSuccess));
      }
    });
  }

  final SyncRepository syncRepository;

  void shouldSync({bool forceSync = false}) async {
    try {
      emit(state.copyWith(status: SyncStatus.loadInProgress, percentage: 0));

      final mustSync = await syncRepository.mustSync();
      final isFirstTimeLogin = await syncRepository.isFirstTimeLogin();

      if (mustSync || forceSync || isFirstTimeLogin) {
        if (isFirstTimeLogin) await syncRepository.setFirstTimeLogin();

        await syncRepository.call();
      }

      emit(state.copyWith(status: SyncStatus.loadSuccess));
    } catch (error) {
      emit(state.copyWith(status: SyncStatus.failure));
    }
  }
}
