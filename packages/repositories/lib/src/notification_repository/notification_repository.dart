import 'package:flutter/foundation.dart';
import 'package:helpers/helpers.dart';

abstract class NotificationRepository {
  Future<void> updateReadDateNotification();
}

class RemoteNotificationRepository implements NotificationRepository {
  RemoteNotificationRepository({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  @override
  Future<void> updateReadDateNotification() async {
    try {
      await httpClient.request(
        url: '$url/${Environment.updateUnreadNotificationPath}',
        method: 'put',
      );
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      rethrow;
    }
  }
}
