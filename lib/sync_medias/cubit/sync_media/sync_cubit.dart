// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:sync_repository/sync_repository.dart';

part 'sync_state.dart';

class SyncCubit extends Cubit<SyncPageState> {
  SyncCubit(
    this.syncRepository,
  ) : super(const SyncPageState(status: SyncPageStatus.initial));

  final SyncRepository syncRepository;

  Future<void> sync() async {
    try {
      emit(state.copyWith(status: SyncPageStatus.loadInProgress));

      await syncRepository();

      emit(state.copyWith(status: SyncPageStatus.loadSuccess));
    } on HttpError catch (e) {
      emit(state.copyWith(status: e == HttpError.unauthorized ? SyncPageStatus.unautorized : SyncPageStatus.loadFailure));
    } catch (_) {
      emit(state.copyWith(status: SyncPageStatus.loadFailure));
    }
  }
}
