import 'package:amandaleme_personal_app/main/factories/http/api_url_factory.dart';
import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../http/authorize_http_client_decorator_factory.dart';

WorkoutsheetRepository makeWorkoutsheetRepositoryFactory(CacheStorage cacheStorage) => RemoteWorkoutsheetRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.workoutsheetPath),
    );
