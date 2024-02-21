import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

import '../factories.dart';

IHomeRepository makeHomeRepositoryFactory(CacheStorage cacheStorage) => HomeRespository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.appHomePath),
    );
