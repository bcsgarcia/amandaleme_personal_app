// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:repositories/repositories.dart';

part './workout_feedback_state.dart';

class WorkoutFeedbackCubit extends Cubit<WorkoutFeedbackState> {
  WorkoutFeedbackCubit(this.workoutRepository) : super(const WorkoutFeedbackState());

  final WorkoutRepository workoutRepository;

  String feedback = "";

  Future<void> createFeedback(String idWorkout) async {
    try {
      emit(state.copyWith(status: WorkoutFeedbackStatus.loadInProgress));
      await workoutRepository.createFeedback(idWorkout: idWorkout, feedback: feedback);
      emit(state.copyWith(status: WorkoutFeedbackStatus.loadSuccess));
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      emit(state.copyWith(status: WorkoutFeedbackStatus.failure));
    }
  }
}
