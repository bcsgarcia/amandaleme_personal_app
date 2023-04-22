import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';

import '../../decorators/decorators.dart';
import '../../factories/http/http.dart';

HttpClient makeAuthorizeHttpClientDecorator(CacheStorage cacheStorage) =>
    AuthorizeHttpClientDecorator(
      cacheStorage: cacheStorage,
      decoratee: makeHttpAdapter(),
    );
