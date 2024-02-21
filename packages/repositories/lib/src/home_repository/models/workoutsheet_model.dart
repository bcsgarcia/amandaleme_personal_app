import 'package:flutter/foundation.dart';

import './models.dart';

class WorkoutSheetModel {
  String id;
  DateTime? date;
  String name;
  int workoutsheetOrder;
  List<WorkoutModel> workouts;

  WorkoutSheetModel({
    required this.id,
    this.date,
    required this.name,
    required this.workoutsheetOrder,
    required this.workouts,
  });

  factory WorkoutSheetModel.fromJson(Map json) {
    try {
      return WorkoutSheetModel(
        id: json['id'],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        name: json['name'],
        workoutsheetOrder: json['workoutsheetOrder'],
        workouts: List<WorkoutModel>.from(
            json['workouts'].map((item) => WorkoutModel.fromJson(item))),
      );
    } catch (error) {
      debugPrint('WorkoutSheetModel: $error');
      debugPrint(json.toString());
      rethrow;
    }
  }

  Map toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'name': name,
      'workoutsheetOrder': workoutsheetOrder,
      'workouts': workouts.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'WorkoutSheetModel{id: $id, date: $date, name: $name, workoutsheetOrder: $workoutsheetOrder, workouts: $workouts}';
  }
}
