import 'package:flutter/foundation.dart';

import 'models.dart';

class WorkoutModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final List<WorkoutMedia> medias;
  final int workoutOrder;
  final String breaktime;
  final String serie;
  bool done;

  WorkoutModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.medias,
    required this.workoutOrder,
    required this.breaktime,
    required this.serie,
    this.done = false,
  });

  factory WorkoutModel.fromJson(Map json) {
    try {
      return WorkoutModel(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        description: json['description'],
        workoutOrder: json['workoutOrder'],
        breaktime: json['breaktime'],
        serie: json['serie'],
        medias: (json['media'] as List).isEmpty
            ? []
            : ((json['media'] as List).first as Map).length < 6
                ? []
                : List<WorkoutMedia>.from(json['media'].map((item) => WorkoutMedia.fromJson(item))),
      );
    } catch (error, stackTrace) {
      debugPrint('WorkoutModel: $error \n ${stackTrace.toString()}');
      debugPrint(json.toString());
      rethrow;
    }
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'medias': medias,
      'workoutOrder': workoutOrder,
      'breaktime': breaktime,
      'serie': serie,
    };
  }

  @override
  String toString() {
    return 'WorkoutModel{id: $id, title: $title, subtitle: $subtitle, description: $description, medias: $medias, workoutOrder: $workoutOrder, breaktime: $breaktime, serie: $serie, done: $done}';
  }
}
