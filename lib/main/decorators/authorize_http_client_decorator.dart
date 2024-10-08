import 'dart:typed_data';

import 'package:helpers/helpers.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  const AuthorizeHttpClientDecorator({
    required this.cacheStorage,
    required this.decoratee,
  });

  final CacheStorage cacheStorage;
  final HttpClient decoratee;

  @override
  Future request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    try {
      final token = await cacheStorage.fetch('token');
      final authorizedHeaders = headers ?? {}
        ..addAll({'Authorization': 'Bearer $token'});
      return await decoratee.request(url: url, method: method, body: body, headers: authorizedHeaders);
    } catch (error) {
      if (error == HttpUnauthorizedException) {
        await cacheStorage.delete('token');
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<dynamic> send({
    required String url,
    required Uint8List fileData,
    String filename = 'file.jpg',
    Map? headers,
  }) async {
    try {
      final token = await cacheStorage.fetch('token');
      final authorizedHeaders = headers ?? {}
        ..addAll({'Authorization': 'Bearer $token'});

      return await decoratee.send(url: url, fileData: fileData, filename: filename, headers: authorizedHeaders);
    } catch (e) {
      throw HttpError.serverError;
    }
  }
}
