// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this.workoutsheetRepository) : super(const FeedbackState(status: FeedbackStatus.initial));

  final WorkoutsheetRepository workoutsheetRepository;

  String textFeedback = '';

  Future<void> createFeedback(String idWorkoutSheet) async {
    try {
      emit(state.copyWith(status: FeedbackStatus.loadInProgress));
      await workoutsheetRepository.createFeedback(idWorkoutSheet, textFeedback);
      emit(state.copyWith(status: FeedbackStatus.loadSuccess));
    } catch (e) {
      emit(state.copyWith(status: FeedbackStatus.failure));
    }
  }
}
