import 'package:http_adapter/http_adapter.dart';

import 'models/models.dart';

abstract class IHomeRepository {
  Future<HomeScreenModel> getHomeScreen();
}

class HomeRespository implements IHomeRepository {
  const HomeRespository({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  @override
  Future<HomeScreenModel> getHomeScreen() async {
    try {
      final response =
          await this.httpClient.request(url: '$url/screen', method: 'get');
      print(response);

      return HomeScreenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
