import './models.dart';

class WorkoutSheetModel {
  String id;
  DateTime? date;
  String name;
  int order;
  List<WorkoutModel> workouts;

  WorkoutSheetModel({
    required this.id,
    this.date,
    required this.name,
    required this.order,
    required this.workouts,
  });

  factory WorkoutSheetModel.fromJson(Map json) {
    return WorkoutSheetModel(
      id: json['id'],
      date: json['date'] == null ? null : DateTime.parse(json['date']),
      name: json['name'],
      order: json['order'],
      workouts: List<WorkoutModel>.from(
          json['workouts'].map((item) => WorkoutModel.fromJson(item))),
    );
  }

  Map toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'name': name,
      'order': order,
      'workouts': workouts.map((item) => item.toJson()).toList(),
    };
  }
}
