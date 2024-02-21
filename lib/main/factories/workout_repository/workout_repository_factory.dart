import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../../../lib.dart';

WorkoutRepository makeWorkoutRepositoryFactory(CacheStorage cacheStorage) => RemoteWorkoutRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.workoutPath),
    );
