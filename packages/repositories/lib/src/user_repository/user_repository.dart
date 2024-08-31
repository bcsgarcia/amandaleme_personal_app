import 'package:flutter/foundation.dart';
import 'package:helpers/helpers.dart';

abstract class UserRepository {
  Future<void> changePassword({required String oldPass, required String newPass});

  Future<void> uploadPhoto(Uint8List newPhoto);
}

class RemoteUserRepository implements UserRepository {
  RemoteUserRepository({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  @override
  Future<void> changePassword({
    required String oldPass,
    required String newPass,
  }) async {
    try {
      final body = {
        "oldpass": oldPass,
        "newpass": newPass,
      };
      await httpClient.request(url: '$url/${Environment.changePassPath}', method: 'post', body: body);
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> uploadPhoto(Uint8List newPhoto) async {
    try {
      final retorno = await httpClient.send(
        url: '${url.replaceAll('/auth', '')}/client/upload',
        fileData: newPhoto,
      );

      // if (retorno.statusCode != 200) {
      //   throw HttpError.serverError;
      // }
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      rethrow;
    }
  }
}
