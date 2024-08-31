// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomePageState> {
  HomeCubit({
    required this.homeRepository,
  }) : super(const HomePageState(status: HomePageStatus.initial));

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
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
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
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      emit(state.copyWith(status: HomePageStatus.failure));
    }
  }
}
