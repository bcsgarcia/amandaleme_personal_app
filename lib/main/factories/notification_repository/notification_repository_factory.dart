import 'package:cache_adapter/cache_adapter.dart';
import 'package:notification_repository/notification_repository.dart';

import '../factories.dart';

NotificationRepository makeNotificationRepositoryFactory(
        CacheStorage cacheStorage) =>
    RemoteNotificationRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV('notification'),
    );
