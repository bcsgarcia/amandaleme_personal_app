import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../../../lib.dart';

WorkoutsheetRepository makeWorkoutsheetRepositoryFactory(CacheStorage cacheStorage) => RemoteWorkoutsheetRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.workoutsheetPath),
    );
