import 'package:equatable/equatable.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

class HomeScreenModel extends Equatable {
  HomeScreenModel({
    required this.myTrainingPlan,
    required this.myWorkousheets,
  });

  final List<WorkoutSheetModel> myTrainingPlan;
  final List<WorkoutSheetModel> myWorkousheets;

  factory HomeScreenModel.fromJson(Map json) => HomeScreenModel(
        myTrainingPlan: List<WorkoutSheetModel>.from(json['myTrainingPlan']
            .map((item) => WorkoutSheetModel.fromJson(item))),
        myWorkousheets: List<WorkoutSheetModel>.from(json['myWorksheets']
            .map((item) => WorkoutSheetModel.fromJson(item))),
      );

  @override
  List<Object?> get props => [myTrainingPlan, myWorkousheets];
}
