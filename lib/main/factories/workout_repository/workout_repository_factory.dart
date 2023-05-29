import 'package:amandaleme_personal_app/main/factories/http/api_url_factory.dart';
import 'package:cache_adapter/cache_adapter.dart';
import 'package:workout_repository/workout_repository.dart';

import '../http/authorize_http_client_decorator_factory.dart';

WorkoutRepository makeWorkoutRepositoryFactory(CacheStorage cacheStorage) => RemoteWorkoutRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV('workout'),
    );
