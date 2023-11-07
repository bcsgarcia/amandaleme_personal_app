// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_repository/home_repository.dart';
import 'package:http_adapter/http_adapter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomePageState> {
  HomeCubit({
    required this.homeRepository,
    // required this.syncRepository,
  }) : super(const HomePageState(status: HomePageStatus.initial));

  final IHomeRepository homeRepository;
  // final SyncRepository syncRepository;

  Future<void> getHomePage() async {
    try {
      emit(state.copyWith(status: HomePageStatus.loadInProgress));

      // final mustSync = await syncRepository.mustSync();
      // final isFirstTimeLogin = await syncRepository.isFirstTimeLogin();

      // if (mustSync || forceSync || isFirstTimeLogin) {
      //   if (isFirstTimeLogin) syncRepository.setFirstTimeLogin();

      //   emit(state.copyWith(status: HomePageStatus.sync));
      //   await syncRepository.call();
      // }

      // if (mustSync) {
      //   emit(state.copyWith(status: HomePageStatus.sync));
      // }

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

  Future<void> prepareHomePageInBackground() async {
    try {
      final getHomeScreen = await homeRepository.getHomeScreen();

      emit(state.copyWith(
        status: HomePageStatus.loadSuccess,
        screenModel: getHomeScreen,
      ));
    } catch (error) {
      emit(state.copyWith(status: HomePageStatus.failure));
    }
  }
}
