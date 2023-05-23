import 'package:home_repository/home_repository.dart';

class WorkoutModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final List<WorkoutMedia> medias;
  final int order;
  final int breaktime;
  final String serie;
  bool done;

  WorkoutModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.medias,
    required this.order,
    required this.breaktime,
    required this.serie,
    this.done = false,
  });

  factory WorkoutModel.fromJson(Map json) {
    return WorkoutModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      order: json['order'],
      breaktime: json['breaktime'],
      serie: json['serie'],
      medias: List<WorkoutMedia>.from(json['media'].map((item) => WorkoutMedia.fromJson(item))),
    );
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'medias': medias,
      'order': order,
      'breaktime': breaktime,
      'serie': serie,
    };
  }
}
