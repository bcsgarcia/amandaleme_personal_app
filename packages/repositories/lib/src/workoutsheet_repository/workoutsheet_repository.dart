import 'package:http_adapter/http_adapter.dart';

abstract class WorkoutsheetRepository {
  Future<void> done(String idWorkoutSheet);
  Future<void> createFeedback(String idWorkoutSheet, String feedback);
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

      return await httpClient.request(url: '$url/${Environment.workoutsheetDonePath}', method: 'post', body: body);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> createFeedback(String idWorkoutSheet, String feedback) async {
    try {
      final body = {
        "idworkoutsheet": idWorkoutSheet,
        "feedback": feedback,
      };

      return await httpClient.request(url: '$url/${Environment.feedbackPath}', method: 'post', body: body);
    } catch (e) {
      rethrow;
    }
  }
}
