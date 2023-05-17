import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_repository/home_repository.dart';

import '../utils/utils.dart';

part 'workoutsheet_video_state.dart';

class WorkoutsheetVideoCubit extends Cubit<WorkoutsheetVideoPageState> {
  WorkoutsheetVideoCubit(this.videoPreparationService) : super(const WorkoutsheetVideoPageState(status: WorkoutsheetVideoPageStatus.initial));

  final VideoPreparationService videoPreparationService;

  void prepareVideoPlayerControllers(WorkoutSheetModel workoutSheet) async {
    emit(state.copyWith(status: WorkoutsheetVideoPageStatus.loadInProgress));

    await videoPreparationService.prepareVideos(workoutSheet.workouts);

    emit(state.copyWith(status: WorkoutsheetVideoPageStatus.loadSuccess));
  }
}
