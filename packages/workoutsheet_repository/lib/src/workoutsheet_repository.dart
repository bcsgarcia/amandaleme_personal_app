import 'package:http_adapter/http_adapter.dart';

abstract class WorkoutsheetRepository {
  Future<void> done(String idWorkoutSheet);
}

class RemoteWorkoutsheetRepository implements WorkoutsheetRepository {
  final HttpClient httpClient;
  final String url;

  RemoteWorkoutsheetRepository({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<void> done(String idWorkoutSheet) async {
    try {
      final body = {"idworkoutsheet": idWorkoutSheet};

      return await httpClient.request(url: '$url/done', method: 'post', body: body);
    } catch (_) {
      rethrow;
    }
  }
}
