// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_repository/home_repository.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:sync_repository/sync_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomePageState> {
  HomeCubit({
    required this.homeRepository,
    required this.syncRepository,
  }) : super(const HomePageState(status: HomePageStatus.initial));

  final IHomeRepository homeRepository;
  final SyncRepository syncRepository;

  Future<void> getHomePage() async {
    try {
      emit(state.copyWith(status: HomePageStatus.loadInProgress));

      if (!await syncRepository.mustSync()) {
        emit(state.copyWith(status: HomePageStatus.sync));
        await syncRepository();
      }

      final getHomeScreen = await homeRepository.getHomeScreen();

      emit(state.copyWith(
        status: HomePageStatus.loadSuccess,
        screenModel: getHomeScreen,
      ));
    } on HttpError catch (_) {
      emit(state.copyWith(status: HomePageStatus.unautorized));
    } catch (_) {
      emit(state.copyWith(status: HomePageStatus.failure));
    }
  }
}
