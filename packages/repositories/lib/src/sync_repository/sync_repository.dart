import 'dart:async';
import 'dart:io' as io;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:helpers/helpers.dart';
import 'package:path_provider/path_provider.dart';

import 'models/models.dart';

mixin Disposable {
  void dispose();
}

abstract class SyncRepository {
  Future<void> call();
  Future<bool> mustSync();
  Future<bool> isFirstTimeLogin();
  Future<void> setFirstTimeLogin();
  Future<void> removeAllData();

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

  List<String> localIdMediaList = [];
  List<String> remoteIdMediaList = [];

  final StreamController<double> _downloadProgressController = StreamController<double>.broadcast();
  int _totalDownloadedBytes = 0;
  int _totalExpectedBytes = 0; // Este é o tamanho total esperado de todos os arquivos

  @override
  Future<bool> isFirstTimeLogin() async {
    // se não esta settado é o first time login
    return !(await cacheStorage.isFirsTimeLoginSet());
  }

  @override
  Future<void> setFirstTimeLogin() {
    localIdMediaList = [];
    return cacheStorage.firstTimeLogin();
  }

  @override
  Future<void> removeAllData() async {
    try {
      localIdMediaList = [];
      remoteIdMediaList = [];
      await cacheStorage.removeFirstTimeLogin();
      await _deleteAllMedias();
    } catch (error) {
      debugPrint("Error removing all data: $error");
    }
  }

  @override
  Future<void> call() async {
    try {
      _totalDownloadedBytes = 0; // Zera o contador de bytes baixados

      Set<String> setLocalIdsMidias = Set<String>.from(localIdMediaList);
      Set<String> setRemoteIdsMidias = Set<String>.from(remoteIdMediaList);

      // Elements present in set1 but not in set2
      Set<String> newMidias = setRemoteIdsMidias.difference(setLocalIdsMidias);

      // Calcular o tamanho total esperado dos arquivos
      await _calculateTotalExpectedBytes(newMidias);

      await downloadAllMidias();

      await listFilesInLocalDirectory();
    } catch (error) {
      debugPrint("Error during call: $error");
    }
  }

  Future<void> _calculateTotalExpectedBytes(Set<String> newMidias) async {
    for (var element in remoteWorkoutsheetMidias) {
      if (newMidias.contains(element.id)) {
        final fileSize = await getFileSize(element.url);
        if (fileSize != null) {
          _totalExpectedBytes += fileSize;
        }
      }
    }
  }

  @override
  Future<bool> mustSync() async {
    localIdMediaList.clear();
    remoteIdMediaList.clear();

    await getRemoteWorkoutSheetMidia();
    await listFilesInLocalDirectory();

    remoteIdMediaList.sort();
    localIdMediaList.sort();

    return localIdMediaList.isEmpty ||
        remoteIdMediaList.length == localIdMediaList.length &&
            remoteIdMediaList.every((element) => localIdMediaList.contains(element));
  }

  Future<void> getRemoteWorkoutSheetMidia() async {
    try {
      final response = await httpClient.request(url: '$url/${Environment.allMediaSyncPath}', method: 'get');
      remoteWorkoutsheetMidias = (response as List).map((item) => MediaSyncModel.fromJson(item)).toList();
      for (var element in remoteWorkoutsheetMidias) {
        remoteIdMediaList.add(element.id);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadAllMidias() async {
    try {
      List<Future<io.File>> futures = [];

      for (var element in remoteWorkoutsheetMidias) {
        if (!localIdMediaList.contains(element.id)) {
          final extensionFile = element.type == 'video' ? 'mp4' : 'png';
          futures.add(downloadMidia(element.url, '${element.id}.$extensionFile'));
        }
      }
      await Future.wait(futures);
    } catch (e) {
      print("Error downloading media: $e");
      rethrow;
    }
  }

  Future<io.File> downloadMidia(String videoUrl, String fileName) async {
    int retries = 3;

    for (int i = 0; i < retries; i++) {
      try {
        final io.HttpClient httpClient = io.HttpClient(); // Usa o HttpClient do dart:io
        final request = await httpClient.getUrl(Uri.parse(videoUrl));
        final response = await request.close();

        // Get the documents directory path
        final directory = await getApplicationDocumentsDirectory();
        final myMidiasDir = io.Directory('${directory.path}/mymidias/');
        final path = myMidiasDir.path;

        if (!await myMidiasDir.exists()) {
          // If the directory does not exist, create it
          await myMidiasDir.create();
        }

        final file = io.File('$path$fileName');

        // Abre o arquivo para escrita
        final sink = file.openWrite();

        // Lê os bytes recebidos e atualiza o progresso
        response.listen(
          (chunk) {
            sink.add(chunk);
            _totalDownloadedBytes += chunk.length;
            final percentage = _totalDownloadedBytes / _totalExpectedBytes;
            _downloadProgressController.add(percentage);
          },
          onDone: () async {
            await sink.close();
          },
          onError: (error) {
            sink.close();
            throw error;
          },
          cancelOnError: true,
        );

        return file;
      } on Exception catch (e) {
        debugPrint('Download failed, retrying... Error: $e');
      }
    }

    debugPrint('Failed to download file after $retries attempts.');
    throw Exception();
  }

  Future<void> listFilesInLocalDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final myMidiasDir = io.Directory('${directory.path}/mymidias/');

    if (!myMidiasDir.existsSync()) {
      myMidiasDir.createSync();
    }

    List<io.FileSystemEntity> files =
        myMidiasDir.listSync().where((entity) => io.FileSystemEntity.isFileSync(entity.path)).toList();

    for (io.FileSystemEntity file in files) {
      final idMedia = file.path.split('/').last.replaceAll('.mp4', '').replaceAll('.png', '');
      if (localIdMediaList.firstWhereOrNull((e) => e == idMedia) == null) {
        localIdMediaList.add(idMedia);
      }
    }
  }

  Future<void> _deleteAllMedias() async {
    final directory = await getApplicationDocumentsDirectory();
    final myMidiasDir = io.Directory('${directory.path}/mymidias/');

    if (myMidiasDir.existsSync()) {
      final List<io.FileSystemEntity> files = myMidiasDir.listSync();

      for (io.FileSystemEntity file in files) {
        try {
          file.deleteSync();
        } catch (e) {
          debugPrint("Error deleting file ${file.path}: $e");
        }
      }
    }
    debugPrint("All media files deleted");
  }

  @override
  Stream<double> get downloadProgressStream => _downloadProgressController.stream;

  Future<int?> getFileSize(String url) async {
    final ioHttpClient = io.HttpClient();
    try {
      final request = await ioHttpClient.headUrl(Uri.parse(url));
      final response = await request.close();

      if (response.statusCode == 200) {
        final contentLength = response.headers.value('content-length');
        if (contentLength != null) {
          return int.parse(contentLength);
        }
      } else {
        debugPrint('Failed to get file size. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred while getting file size: $e');
    } finally {
      ioHttpClient.close();
    }
    return null;
  }

  @override
  void dispose() {
    _downloadProgressController.close();
  }
}
