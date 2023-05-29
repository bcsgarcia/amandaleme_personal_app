import 'package:amandaleme_personal_app/main/factories/http/api_url_factory.dart';
import 'package:cache_adapter/cache_adapter.dart';
import 'package:user_repository/user_repository.dart';

import '../http/authorize_http_client_decorator_factory.dart';

UserRepository makeUserRepositoryFactory(CacheStorage cacheStorage) => RemoteUserRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV('auth'),
    );
