import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../http/http.dart';

Authentication makeAuthenticationRepositoryFactory(CacheStorage cacheStorage) => RemoteAuthentication(
      httpClient: makeHttpAdapter(),
      cacheStorage: cacheStorage,
      url: makeApiUrlDEV('${Environment.authPath}/${Environment.appPath}'),
    );
