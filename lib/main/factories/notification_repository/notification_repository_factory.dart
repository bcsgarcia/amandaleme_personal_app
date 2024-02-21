import 'package:helpers/helpers.dart';
import 'package:repositories/repositories.dart';

import '../factories.dart';

NotificationRepository makeNotificationRepositoryFactory(CacheStorage cacheStorage) => RemoteNotificationRepository(
      httpClient: makeAuthorizeHttpClientDecorator(cacheStorage),
      url: makeApiUrlDEV(Environment.notificationPath),
    );
