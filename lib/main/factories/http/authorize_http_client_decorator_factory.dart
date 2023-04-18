import 'package:http_adapter/http_adapter.dart';

import '../cache/cache.dart';

import '../../decorators/decorators.dart';
import '../../factories/http/http.dart';

HttpClient makeAuthorizeHttpClientDecorator() => AuthorizeHttpClientDecorator(
      cacheStorage: makeLocalStorageAdapter(),
      decoratee: makeHttpAdapter(),
    );
