import 'package:authentication_repository/authentication_repository.dart';
import 'package:cache_adapter/cache_adapter.dart';

import '../http/http.dart';

Authentication makeAuthenticationRepositoryFactory(CacheStorage cacheStorage) =>
    RemoteAuthentication(
      httpClient: makeHttpAdapter(),
      cacheStorage: cacheStorage,
      url: makeApiUrlDEV('auth/app'),
    );
