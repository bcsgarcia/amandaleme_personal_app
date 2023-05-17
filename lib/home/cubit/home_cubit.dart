// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_repository/home_repository.dart';
import 'package:http_adapter/http_adapter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomePageState> {
  HomeCubit(this.homeRepository)
      : super(const HomePageState(status: HomePageStatus.initial));

  final IHomeRepository homeRepository;

  Future<void> getHomePage() async {
    try {
      emit(state.copyWith(status: HomePageStatus.loadInProgress));
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
