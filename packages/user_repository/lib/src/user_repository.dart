import 'package:http_adapter/http_adapter.dart';

abstract class UserRepository {
  Future<void> changePassword({required String oldPass, required String newPass});
}

class RemoteUserRepository implements UserRepository {
  RemoteUserRepository({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  @override
  Future<void> changePassword({
    required String oldPass,
    required String newPass,
  }) async {
    try {
      final body = {
        "oldpass": oldPass,
        "newpass": newPass,
      };
      await httpClient.request(url: '$url/app/change-pass', method: 'post', body: body);
    } catch (error) {
      rethrow;
    }
  }
}
