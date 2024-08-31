import 'package:equatable/equatable.dart';

import '../../../repositories_base.dart';

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

  factory HomeScreenModel.fromJson(Map json) {
    return HomeScreenModel(
      myTrainingPlan: (json['myTrainingPlan'] as List).first == null
          ? []
          : List<WorkoutSheetModel>.from(json['myTrainingPlan'].map((item) => WorkoutSheetModel.fromJson(item))),
      myWorkousheets:
          List<WorkoutSheetModel>.from(json['myWorksheets'].map((item) => WorkoutSheetModel.fromJson(item))),
      drawerMenu: DrawerScreenModel.fromJson(json['drawerMenu']),
      notifications:
          List<NotificationModel>.from(json['notifications'].map((item) => NotificationModel.fromJson(item))),
    );
  }

  @override
  List<Object?> get props => [myTrainingPlan, myWorkousheets];
}
