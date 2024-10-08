import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:helpers/helpers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repositories/repositories.dart';

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
        videoControllerModel.mediaFileList.add(File(path));
        filesList.add(File(path));
      }
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
}

class VideoControllerModel {
  VideoControllerModel({
    required this.idWorkout,
    required this.mediaFileList,
  });

  final String idWorkout;
  final List<File> mediaFileList;
}
