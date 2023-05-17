import 'package:home_repository/home_repository.dart';
import 'package:video_player/video_player.dart';

class VideoPreparationService {
  List<VideoControllerModel> controllers = [];

  Future<VideoPlayerController> prepareVideos(List<WorkoutModel> workouts) async {
    // Prepare the first video
    VideoPlayerController firstController = VideoPlayerController.network(workouts[0].videoUrl);
    await firstController.initialize();
    await firstController.seekTo(const Duration(milliseconds: 200));

    controllers.add(VideoControllerModel(
      controller: firstController,
      idWorkout: workouts[0].id,
    ));

    // Prepare the rest of the videos in parallel
    List<Future> futures = workouts.skip(1).map((WorkoutModel workout) async {
      VideoPlayerController controller = VideoPlayerController.network(workout.videoUrl);

      await controller.initialize();
      await controller.seekTo(const Duration(milliseconds: 200));

      controllers.add(VideoControllerModel(idWorkout: workout.id, controller: controller));
    }).toList();

    await Future.wait(futures);

    return firstController;
  }
}

class VideoControllerModel {
  VideoControllerModel({
    required this.idWorkout,
    required this.controller,
  });

  final String idWorkout;
  final VideoPlayerController controller;
}
