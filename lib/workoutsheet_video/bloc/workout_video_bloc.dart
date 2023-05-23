import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'workout_video_event.dart';
part 'workout_video_state.dart';

class WorkoutVideoBloc extends Bloc<WorkoutVideoEvent, WorkoutVideoPageState> {
  WorkoutVideoBloc()
      : super(
          const WorkoutVideoPageState(isPlaying: false, currentVideoIndex: 0),
        ) {}
}
