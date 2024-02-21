import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:user_repository/user_repository.dart';

import '../../../lib.dart';

UserRepository makeUserRepositoryFactory(CacheStorage cacheStorage) => RemoteUserRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.authPath),
    );
