import 'dart:async'; // Import needed for StreamController

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
  // Private constructor
  RemoteAuthentication._({
    required this.httpClient,
    required this.cacheStorage,
    required this.url,
    required StreamController<UserAuthenticationModel> userStreamController,
  }) : _userStreamController = userStreamController;

  factory RemoteAuthentication({
    required HttpClient httpClient,
    required CacheStorage cacheStorage,
    required String url,
  }) {
    final userStreamController =
        StreamController<UserAuthenticationModel>.broadcast();
    return RemoteAuthentication._(
      httpClient: httpClient,
      cacheStorage: cacheStorage,
      url: url,
      userStreamController: userStreamController,
    );
  }

  final StreamController<UserAuthenticationModel> _userStreamController;
  final HttpClient httpClient;
  final String url;
  final CacheStorage cacheStorage;

  // User cache key.
  // Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  // Stream getter
  @override
  Stream<UserAuthenticationModel> get user => _userStreamController.stream;

  // Getter for the current user
  @override
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
      final user = UserAuthenticationModel.fromJson(httpResponse);

      // Notify listeners that the user has changed
      _userStreamController.add(user);

      return user;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    cacheStorage.clear();
    // Notify listeners that the user has logged out
    _userStreamController.add(UserAuthenticationModel(token: ''));
  }

  void dispose() {
    _userStreamController.close();
  }
}
