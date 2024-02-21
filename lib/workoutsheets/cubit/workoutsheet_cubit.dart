// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'workoutsheet_state.dart';

class WorkoutsheetCubit extends Cubit<WorkoutsheetPageState> {
  WorkoutsheetCubit(
    this.workoutsheetRepository,
  ) : super(
          const WorkoutsheetPageState(status: WorkoutsheetPageStatus.initial),
        );

  final WorkoutsheetRepository workoutsheetRepository;

  void workoutsheetComplete() {
    emit(state.copyWith(status: WorkoutsheetPageStatus.complete));
  }

  void workoutsheetIncomplete() {
    emit(state.copyWith(status: WorkoutsheetPageStatus.incomplete));
  }

  void workoutsheetDone(String idWorkoutsheet) async {
    try {
      emit(state.copyWith(status: WorkoutsheetPageStatus.loadInProgress));
      await workoutsheetRepository.done(idWorkoutsheet);
      emit(state.copyWith(status: WorkoutsheetPageStatus.loadSuccess));
    } catch (e) {
      emit(state.copyWith(status: WorkoutsheetPageStatus.loadFailure));
    }
  }
}
