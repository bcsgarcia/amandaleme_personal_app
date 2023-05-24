import 'dart:async'; // Import needed for StreamController

import 'package:cache_adapter/cache_adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:http_adapter/http_adapter.dart';

import 'models/models.dart';

abstract class Authentication {
  Future<UserAuthenticationModel> authWithEmailAndPassword(
    AuthenticationParam param, {
    required bool keepConnected,
  });

  Future<void> refreshToken();

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
    final userStreamController = StreamController<UserAuthenticationModel>.broadcast();
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
  Future<UserAuthenticationModel> authWithEmailAndPassword(AuthenticationParam param, {required bool keepConnected}) async {
    final body = RemoteAuthenticationParams.fromDomain(param).toJson();
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      await saveTokenLocally(httpResponse['accessToken']);
      final user = UserAuthenticationModel.fromJson(httpResponse);

      // Notify listeners that the user has changed
      _userStreamController.add(user);

      if (keepConnected) {
        await cacheStorage.save(key: 'keepConnected', value: true);
      }

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

  @override
  Future<void> refreshToken() async {
    try {
      //   final httpResponse = await httpClient.request(url: '$url/refresh', method: 'post');
      //   await saveTokenLocally(httpResponse['accessToken']);

      //   final user = UserAuthenticationModel.fromJson(httpResponse);

      //   _userStreamController.add(user);

      await Future.delayed(Duration(seconds: 10));
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    _userStreamController.close();
  }

  Future<void> saveTokenLocally(String token) async {
    await cacheStorage.save(key: 'token', value: token);
  }
}
