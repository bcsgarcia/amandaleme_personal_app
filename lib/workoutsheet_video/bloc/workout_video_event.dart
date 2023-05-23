part of 'workout_video_bloc.dart';

@immutable
abstract class WorkoutVideoEvent {}

class PlayCurrentVideo extends WorkoutVideoEvent {}

class PauseCurrentVideo extends WorkoutVideoEvent {}
