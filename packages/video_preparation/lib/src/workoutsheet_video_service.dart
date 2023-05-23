import 'dart:io';

import 'package:home_repository/home_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoPreparationService {
  List<String> allMediaFilesPaths = [];

  List<VideoControllerModel> controllers = [];

  Future<List<VideoControllerModel>> prepareVideos(List<WorkoutModel> workouts) async {
    await listFilesInLocalDirectory();

    for (WorkoutModel workout in workouts) {
      final videoControllerModel = VideoControllerModel(idWorkout: workout.id, controllers: []);

      final workoutMedias = workout.medias.where((media) => media.type == 'video').toList();

      final mediasFiles = getMediasFilesOfTheWorkout(workoutMedias);

      for (var path in mediasFiles) {
        VideoPlayerController controller = VideoPlayerController.file(File(path));
        await controller.initialize();
        videoControllerModel.controllers.add(controller);
      }

      controllers.add(videoControllerModel);
    }
    return controllers;
  }

  Future<void> listFilesInLocalDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final myMidiasDir = Directory('${directory.path}/mymidias/');

    List<FileSystemEntity> files = myMidiasDir.listSync().where((entity) => FileSystemEntity.isFileSync(entity.path)).toList();

    for (FileSystemEntity file in files) {
      allMediaFilesPaths.add(file.path);
    }
  }

  List<String> getMediasFilesOfTheWorkout(List<WorkoutMedia> medias) {
    List<String> mediaFilesPaths = [];

    for (var media in medias) {
      mediaFilesPaths.add(allMediaFilesPaths.firstWhere((element) => element.split('/').last.replaceAll('.mp4', '') == media.id));
    }

    print(mediaFilesPaths);
    return mediaFilesPaths;
  }
}

class VideoControllerModel {
  VideoControllerModel({
    required this.idWorkout,
    required this.controllers,
  });

  final String idWorkout;
  final List<VideoPlayerController> controllers;
}
