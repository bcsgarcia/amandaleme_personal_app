import 'dart:async'; // Import needed for StreamController

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:helpers/helpers.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

import 'models/models.dart';

enum LocalAuthStatusEnum {
  success,
  failure,
  notEnrolled,
  lockedOut,
  errorDefault,
}

abstract class Authentication {
  Future<UserAuthenticationModel> authWithEmailAndPassword(
    AuthenticationParam param, {
    required bool keepConnected,
  });

  Future<void> refreshToken();

  Future<LocalAuthStatusEnum> requestLocalAuth();

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
  Future<UserAuthenticationModel> authWithEmailAndPassword(AuthenticationParam param,
      {required bool keepConnected}) async {
    final body = RemoteAuthenticationParams.fromDomain(param).toJson();
    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);

      await saveTokenLocally(httpResponse['accessToken']);
      await saveOptionKeepConnectedLocally(keepConnected);

      final user = UserAuthenticationModel.fromJson(httpResponse);

      _userStreamController.add(user);

      return user;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    cacheStorage.clear();
    _userStreamController.add(UserAuthenticationModel(token: ''));
  }

  @override
  Future<void> refreshToken() async {
    try {
      final _token = cacheStorage.fetch('token');

      final _body = {
        "token": _token,
      };
      final httpResponse =
          await httpClient.request(url: '$url/${Environment.refreshTokenPath}', method: 'post', body: _body);
      await saveTokenLocally(httpResponse['accessToken']);

      final user = UserAuthenticationModel.fromJson(httpResponse);

      _userStreamController.add(user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<LocalAuthStatusEnum> requestLocalAuth() async {
    if (await getOptionKeepConnectedLocally() == false) {
      throw LocalAuthStatusEnum.failure;
    }

    final LocalAuthentication auth = LocalAuthentication();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    if (canAuthenticate) {
      try {
        final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Por favor, autentique-se para entrar no app',
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Autenticação requerida',
              biometricHint: '',
              cancelButton: 'Não, obrigado',
            ),
            IOSAuthMessages(
              cancelButton: 'Não, obrigado',
            ),
          ],
        );

        if (didAuthenticate) {
          await refreshToken();
          return LocalAuthStatusEnum.success;
        } else {
          return LocalAuthStatusEnum.failure;
        }
      } on PlatformException catch (e) {
        if (e.code == auth_error.notEnrolled) {
          await refreshToken();
          return LocalAuthStatusEnum.notEnrolled;
        } else if (e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut) {
          return LocalAuthStatusEnum.lockedOut;
        } else {
          return LocalAuthStatusEnum.errorDefault;
        }
      }
    } else {
      return LocalAuthStatusEnum.failure;
    }
  }

  void dispose() {
    _userStreamController.close();
  }

  Future<void> saveTokenLocally(String token) async {
    await cacheStorage.save(key: 'token', value: token);
  }

  Future<void> saveOptionKeepConnectedLocally(bool option) async {
    await cacheStorage.save(key: 'keepConnected', value: option.toString());
  }

  Future<bool> getOptionKeepConnectedLocally() async {
    final option = await cacheStorage.fetch('keepConnected') as String?;
    return option?.toLowerCase() == 'true';
  }
}
