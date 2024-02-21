import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

import '../../../lib.dart';

WorkoutsheetRepository makeWorkoutsheetRepositoryFactory(CacheStorage cacheStorage) => RemoteWorkoutsheetRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.workoutsheetPath),
    );
