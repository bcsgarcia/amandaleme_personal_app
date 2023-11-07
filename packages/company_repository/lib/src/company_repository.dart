import 'package:company_repository/src/models/meet_app_screen_model.dart';
import 'package:http_adapter/http_adapter.dart';

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
      final response = await this.client.request(url: url, method: 'get');

      final teste = MeetAppScreenModel.fromJson(response);
      return teste;
    } catch (e) {
      throw e;
    }
  }
}
