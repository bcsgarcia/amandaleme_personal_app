import 'package:helpers/helpers.dart';

abstract class WorkoutRepository {
  Future<void> createFeedback({
    required String idWorkout,
    required String feedback,
  });
}

class RemoteWorkoutRepository implements WorkoutRepository {
  RemoteWorkoutRepository({
    required this.httpClient,
    required this.url,
  });

  final HttpClient httpClient;
  final String url;

  @override
  Future<void> createFeedback({required String idWorkout, required String feedback}) async {
    try {
      final body = {"idworkout": idWorkout, "feedback": feedback};

      await httpClient.request(url: '$url/${Environment.feedbackPath}', method: 'post', body: body);
    } catch (e) {
      rethrow;
    }
  }
}
