import 'package:http_adapter/http_adapter.dart';

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
      await this.httpClient.request(
            url: '$url/${Environment.updateUnreadNotificationPath}',
            method: 'put',
          );
    } catch (_) {
      rethrow;
    }
  }
}
