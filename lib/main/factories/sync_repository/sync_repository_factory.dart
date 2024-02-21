import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../factories.dart';

SyncRepository makeSyncRepositoryFactory(CacheStorage cacheStorage) => RemoteSyncRepostory(
      cacheStorage: cacheStorage,
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.workoutsheetPath),
    );
