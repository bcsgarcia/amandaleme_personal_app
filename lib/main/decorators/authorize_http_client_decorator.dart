import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';

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
      return await decoratee.request(
          url: url, method: method, body: body, headers: authorizedHeaders);
    } catch (error) {
      if (error is HttpError && error != HttpError.unauthorized) {
      } else {
        await cacheStorage.delete('token');
        throw HttpError.forbidden;
      }
    }
  }
}
