import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

import '../../../lib.dart';

WorkoutRepository makeWorkoutRepositoryFactory(CacheStorage cacheStorage) => RemoteWorkoutRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.workoutPath),
    );
