import 'package:authentication_repository/authentication_repository.dart';

import '../../factories/cache/cache.dart';
import '../http/http.dart';

Authentication makeAuthenticationRepositoryFactory() => RemoteAuthentication(
      httpClient: makeHttpAdapter(),
      cacheStorage: makeLocalStorageAdapter(),
      url: makeApiUrlDEV('auth'),
    );
