import 'package:http_adapter/http_adapter.dart';

import 'models/models.dart';

abstract class IWorkoutSheetRepository {
  Future<HomeScreenModel> getHomeScreen();
}

class WorkoutSheetRespository implements IWorkoutSheetRepository {
  const WorkoutSheetRespository({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  @override
  Future<HomeScreenModel> getHomeScreen() async {
    try {
      final response =
          await this.httpClient.request(url: '$url/screen/home', method: 'get');
      print(response);

      return HomeScreenModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
