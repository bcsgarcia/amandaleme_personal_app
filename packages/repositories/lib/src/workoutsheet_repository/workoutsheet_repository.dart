import 'package:flutter/foundation.dart';
import 'package:helpers/helpers.dart';

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
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
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
    } catch (error, stacktrace) {
      debugPrint('${error.toString()}\n${stacktrace.toString()}');
      rethrow;
    }
  }
}
