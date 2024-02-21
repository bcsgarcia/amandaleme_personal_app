import 'package:helpers/helpers.dart';

import 'models/models.dart';

abstract class CompanyRepository {
  Future<MeetAppScreenModel> getMeetAppScreen();
}

class RemoteCompanyRepository implements CompanyRepository {
  RemoteCompanyRepository({
    required this.client,
    required this.url,
  });

  final HttpClient client;
  final String url;

  @override
  Future<MeetAppScreenModel> getMeetAppScreen() async {
    try {
      final response = await client.request(url: url, method: 'get');

      final teste = MeetAppScreenModel.fromJson(response);
      return teste;
    } catch (e) {
      rethrow;
    }
  }
}
