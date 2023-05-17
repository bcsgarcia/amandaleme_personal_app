import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'workoutsheet_state.dart';

class WorkoutsheetCubit extends Cubit<WorkoutsheetPageState> {
  WorkoutsheetCubit()
      : super(
          const WorkoutsheetPageState(status: WorkoutsheetPageStatus.initial),
        );

  void workoutsheetComplete() {
    emit(state.copyWith(status: WorkoutsheetPageStatus.complete));
  }

  void workoutsheetIncomplete() {
    emit(state.copyWith(status: WorkoutsheetPageStatus.incomplete));
  }
}
