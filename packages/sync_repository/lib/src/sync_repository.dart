import 'dart:async';
import 'dart:io';

import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:path_provider/path_provider.dart';

import 'models/modes.dart';

mixin Disposable {
  void dispose();
}

abstract class SyncRepository {
  Future<void> call();
  Future<bool> mustSync();

  Stream<double> get downloadProgressStream;
}

class RemoteSyncRepostory implements SyncRepository, Disposable {
  RemoteSyncRepostory({
    required this.cacheStorage,
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final CacheStorage cacheStorage;
  final String url;

  List<MediaSyncModel> remoteWorkoutsheetMidias = [];

  List<String> localIdsMidias = [];
  List<String> remoteIdsMidias = [];

  final StreamController<double> _downloadProgressController = StreamController<double>.broadcast();

  @override
  Future<void> call() async {
    int filesDownloaded = 0;

    Set<String> setLocalIdsMidias = Set<String>.from(localIdsMidias);
    Set<String> setRemoteIdsMidias = Set<String>.from(remoteIdsMidias);

    // Elements present in set1 but not in set2
    Set<String> newMidias = setRemoteIdsMidias.difference(setLocalIdsMidias);
    print(newMidias);

    // This function will be called each time a file finishes downloading.
    void onFileDownloaded() {
      filesDownloaded++;
      _downloadProgressController.sink.add(filesDownloaded / newMidias.length);
    }

    await downloadAllMidias(onFileDownloaded);

    await listFilesInLocalDirectory();

    print(localIdsMidias);
  }

  @override
  Future<bool> mustSync() async {
    await getRemoteWorkoutSheetMidia();
    await listFilesInLocalDirectory();

    remoteIdsMidias.sort();
    localIdsMidias.sort();

    return remoteIdsMidias.length == localIdsMidias.length && remoteIdsMidias.every((element) => localIdsMidias.contains(element));
  }

  Future<void> getRemoteWorkoutSheetMidia() async {
    try {
      final response = await this.httpClient.request(url: '${url}all/medias-sync', method: 'get');
      remoteWorkoutsheetMidias = (response as List).map((item) => MediaSyncModel.fromJson(item)).toList();
      for (var element in remoteWorkoutsheetMidias) {
        remoteIdsMidias.add(element.id);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadAllMidias(void Function() onFileDownloaded) async {
    try {
      // Prepare a list of Future instances
      List<Future<File>> futures = [];

      for (var element in remoteWorkoutsheetMidias) {
        if (!localIdsMidias.contains(element.id)) {
          final extensionFile = element.type == 'video' ? 'mp4' : 'png';
          futures.add(downloadMidia(element.url, '${element.id}.$extensionFile', onFileDownloaded));
        }
      }

      // Wait for all futures to complete
      await Future.wait(futures);
    } catch (e) {
      rethrow;
    }
  }

  Future<File> downloadMidia(String videoUrl, String fileName, void Function() onFileDownloaded) async {
    int retries = 3;
    Exception lastException;

    for (int i = 0; i < retries; i++) {
      try {
        final response = await httpClient.request(url: videoUrl, method: 'download');

        // Get the documents directory path
        final directory = await getApplicationDocumentsDirectory();
        final myMidiasDir = Directory('${directory.path}/mymidias/');
        final path = myMidiasDir.path;

        if (!await myMidiasDir.exists()) {
          // If the directory does not exist, create it
          final newDirectory = await myMidiasDir.create();
          print("Directory Created: ${newDirectory.path}");
        }

        // Create a new file in the documents directory
        final file = File('$path$fileName');

        // Write the response body bytes to the file
        await file.writeAsBytes(response);

        onFileDownloaded();

        return file;
      } on Exception catch (e) {
        lastException = e;
        print('Download failed, retrying...');
      }
    }

    // If the code reached here, it means all retry attempts have failed
    print('Failed to download file after $retries attempts.');
    throw Exception();
  }

  Future<void> listFilesInLocalDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final myMidiasDir = Directory('${directory.path}/mymidias/');

    if (!myMidiasDir.existsSync()) {
      myMidiasDir.createSync();
    }

    List<FileSystemEntity> files = myMidiasDir.listSync().where((entity) => FileSystemEntity.isFileSync(entity.path)).toList();

    for (FileSystemEntity file in files) {
      localIdsMidias.add(file.path.split('/').last.replaceAll('.mp4', '').replaceAll('.png', ''));
    }
  }

  @override
  Stream<double> get downloadProgressStream => _downloadProgressController.stream;

  @override
  void dispose() {
    _downloadProgressController.close();
  }
}
