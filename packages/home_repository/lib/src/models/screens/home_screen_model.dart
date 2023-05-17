import 'package:equatable/equatable.dart';
import 'package:notification_repository/notification_repository.dart';

import '../models.dart';

class HomeScreenModel extends Equatable {
  HomeScreenModel({
    required this.myTrainingPlan,
    required this.myWorkousheets,
    required this.drawerMenu,
    required this.notifications,
  });

  final List<WorkoutSheetModel> myTrainingPlan;
  final List<WorkoutSheetModel> myWorkousheets;
  final List<NotificationModel> notifications;
  final DrawerScreenModel drawerMenu;

  factory HomeScreenModel.fromJson(Map json) => HomeScreenModel(
        myTrainingPlan: List<WorkoutSheetModel>.from(json['myTrainingPlan']
            .map((item) => WorkoutSheetModel.fromJson(item))),
        myWorkousheets: List<WorkoutSheetModel>.from(json['myWorksheets']
            .map((item) => WorkoutSheetModel.fromJson(item))),
        drawerMenu: DrawerScreenModel.fromJson(json['drawerMenu']),
        notifications: List<NotificationModel>.from(json['notifications']
            .map((item) => NotificationModel.fromJson(item))),
      );

  @override
  List<Object?> get props => [myTrainingPlan, myWorkousheets];
}
