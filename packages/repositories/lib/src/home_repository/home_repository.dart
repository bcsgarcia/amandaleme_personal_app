import 'package:helpers/helpers.dart';

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
      final response = await httpClient.request(url: '$url/${Environment.screenPath}', method: 'get');
      print(response);

      return HomeScreenModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
