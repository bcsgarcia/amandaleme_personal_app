import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../../../lib.dart';

UserRepository makeUserRepositoryFactory(CacheStorage cacheStorage) => RemoteUserRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.authPath),
    );
