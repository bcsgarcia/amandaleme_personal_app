import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

import '../factories.dart';

SyncRepository makeSyncRepositoryFactory(CacheStorage cacheStorage) => RemoteSyncRepostory(
      cacheStorage: cacheStorage,
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.workoutsheetPath),
    );
