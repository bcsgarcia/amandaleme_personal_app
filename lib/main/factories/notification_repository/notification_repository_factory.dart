import 'package:cache_adapter/cache_adapter.dart';
import 'package:http_adapter/http_adapter.dart';
import 'package:repositories/repositories.dart';

import '../factories.dart';

NotificationRepository makeNotificationRepositoryFactory(CacheStorage cacheStorage) => RemoteNotificationRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.notificationPath),
    );
