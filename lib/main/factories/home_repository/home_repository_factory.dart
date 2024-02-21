import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../factories.dart';

IHomeRepository makeHomeRepositoryFactory(CacheStorage cacheStorage) => HomeRespository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.appHomePath),
    );
