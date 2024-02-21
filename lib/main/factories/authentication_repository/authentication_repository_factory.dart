import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

import '../http/http.dart';

Authentication makeAuthenticationRepositoryFactory(CacheStorage cacheStorage) => RemoteAuthentication(
      httpClient: makeHttpAdapter(),
      cacheStorage: cacheStorage,
      url: makeApiUrlDEV('${Environment.authPath}/${Environment.appPath}'),
    );
