import 'package:equatable/equatable.dart';
import 'package:home_repository/src/models/screens/drawer_screen_model.dart';

import '../models.dart';

class HomeScreenModel extends Equatable {
  HomeScreenModel({
    required this.myTrainingPlan,
    required this.myWorkousheets,
    required this.drawerMenu,
  });

  final List<WorkoutSheetModel> myTrainingPlan;
  final List<WorkoutSheetModel> myWorkousheets;
  final DrawerScreenModel drawerMenu;

  factory HomeScreenModel.fromJson(Map json) => HomeScreenModel(
        myTrainingPlan: List<WorkoutSheetModel>.from(json['myTrainingPlan']
            .map((item) => WorkoutSheetModel.fromJson(item))),
        myWorkousheets: List<WorkoutSheetModel>.from(json['myWorksheets']
            .map((item) => WorkoutSheetModel.fromJson(item))),
        drawerMenu: DrawerScreenModel.fromJson(json['drawerMenu']),
      );

  @override
  List<Object?> get props => [myTrainingPlan, myWorkousheets];
}
