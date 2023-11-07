import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:home_repository/home_repository.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:path_provider/path_provider.dart';

class VideoPreparationService {
  List<String> allMediaFilesPaths = [];

  List<VideoControllerModel> videoControllerModelList = [];

  Future<List<VideoControllerModel>> prepareVideos(List<WorkoutModel> workouts) async {
    try {
      await listFilesInLocalDirectory();

      videoControllerModelList = [];

      for (WorkoutModel workout in workouts) {
        final videoControllerModel = VideoControllerModel(idWorkout: workout.id, mediaFileList: []);

        final ids = <String>{};
        final workoutMedias = workout.medias.where((media) {
          return media.type == 'video' && ids.add(media.id);
        }).toList();

        final mediasFiles = getMediasFilesOfTheWorkout(workoutMedias);

        for (var path in mediasFiles) {
          videoControllerModel.mediaFileList.add(File(path));
        }

        videoControllerModelList.add(videoControllerModel);
      }
      return videoControllerModelList;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }

  Future<List<File>> getWorkoutMediaFilesVideos(List<WorkoutModel> workouts) async {
    await listFilesInLocalDirectory();

    List<File> filesList = [];

    for (WorkoutModel workout in workouts) {
      final videoControllerModel = VideoControllerModel(idWorkout: workout.id, mediaFileList: []);

      final workoutMedias = workout.medias.where((media) => media.type == 'video').toList();

      final mediasFiles = getMediasFilesOfTheWorkout(workoutMedias);

      for (var path in mediasFiles) {
        // VideoPlayerController controller = VideoPlayerController.file(File(path));
        // await controller.initialize();
        videoControllerModel.mediaFileList.add(File(path));
        filesList.add(File(path));
      }

      // controllers.add(videoControllerModel);
    }
    return filesList;
  }

  Future<void> listFilesInLocalDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final myMidiasDir = Directory('${directory.path}/${Environment.myMediasDirectoryPath}/');

    List<FileSystemEntity> files =
        myMidiasDir.listSync().where((entity) => FileSystemEntity.isFileSync(entity.path)).toList();

    for (FileSystemEntity file in files) {
      allMediaFilesPaths.add(file.path);
    }
  }

  List<String> getMediasFilesOfTheWorkout(List<WorkoutMedia> medias) {
    List<String> mediaFilesPaths = [];

    for (var media in medias) {
      final mediaFile =
          allMediaFilesPaths.firstWhereOrNull((element) => element.split('/').last.replaceAll('.mp4', '') == media.id);

      if (mediaFile != null) {
        mediaFilesPaths.add(mediaFile);
      }
    }

    return mediaFilesPaths;
  }

  // Future<void> _disposeControllers() async {
  //   for (VideoControllerModel model in controllers) {
  //     for (VideoPlayerController controller in model.controllers) {
  //       await controller.dispose();
  //     }
  //   }
  //   controllers.clear();
  // }
}

class VideoControllerModel {
  VideoControllerModel({
    required this.idWorkout,
    required this.mediaFileList,
  });

  final String idWorkout;
  final List<File> mediaFileList;
}
