import 'package:cache_adapter/cache_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:http_adapter/http_adapter.dart';

import 'models/models.dart';

abstract class Authentication {
  Future<UserAuthenticationModel> authWithEmailAndPassword(
    AuthenticationParam param,
  );

  Stream<UserAuthenticationModel> get user;
  UserAuthenticationModel get currentUser;

  Future<void> logout();
}

class RemoteAuthentication implements Authentication {
  const RemoteAuthentication({
    required this.httpClient,
    required this.cacheStorage,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;
  final CacheStorage cacheStorage;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Stream<UserAuthenticationModel> get user async* {
    // await cacheStorage.clear();
    final _token = await cacheStorage.fetch('token');
    yield UserAuthenticationModel(token: _token == null ? '' : _token);
  }

  UserAuthenticationModel get currentUser {
    final _token = cacheStorage.fetch('token');
    return UserAuthenticationModel(token: _token == null ? '' : _token);
  }

  @override
  Future<UserAuthenticationModel> authWithEmailAndPassword(
      AuthenticationParam param) async {
    final body = RemoteAuthenticationParams.fromDomain(param).toJson();
    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);
      await cacheStorage.save(key: 'token', value: httpResponse['accessToken']);
      return UserAuthenticationModel.fromJson(httpResponse);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    cacheStorage.clear();
  }
}
