import 'package:helpers/helpers.dart';

import '../../decorators/decorators.dart';
import '../../factories/http/http.dart';

HttpClient makeAuthorizeHttpClientDecorator(CacheStorage cacheStorage) => AuthorizeHttpClientDecorator(
      cacheStorage: cacheStorage,
      decoratee: makeHttpAdapter(),
    );
