import 'package:cache_adapter/cache_adapter.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../factories.dart';

IWorkoutSheetRepository makeWorkoutSheetRepositoryFactory(
        CacheStorage cacheStorage) =>
    WorkoutSheetRespository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV('workoutsheet'),
    );
