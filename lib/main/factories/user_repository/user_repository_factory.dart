import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

import '../../../lib.dart';

UserRepository makeUserRepositoryFactory(CacheStorage cacheStorage) => RemoteUserRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.authPath),
    );
