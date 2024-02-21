// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

part 'sync_media_page_state.dart';

class SyncMediaPageCubit extends Cubit<SyncMadiaPageState> {
  SyncMediaPageCubit(
    this.syncRepository,
  ) : super(const SyncMadiaPageState(status: SyncPageStatus.initial));

  final SyncRepository syncRepository;

  Future<void> sync() async {
    try {
      emit(state.copyWith(status: SyncPageStatus.loadInProgress));

      await syncRepository();

      emit(state.copyWith(status: SyncPageStatus.loadSuccess));
    } on HttpError catch (e) {
      emit(state.copyWith(
          status: e == HttpError.unauthorized ? SyncPageStatus.unautorized : SyncPageStatus.loadFailure));
    } catch (_) {
      emit(state.copyWith(status: SyncPageStatus.loadFailure));
    }
  }
}
