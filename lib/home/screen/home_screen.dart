import 'package:amandaleme_personal_app/app/common_widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:home_repository/home_repository.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.homeScreenModel,
  });

  final HomeScreenModel homeScreenModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawerMenu(
        drawerScreenModel: homeScreenModel.drawerMenu,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppHeader(),
          const SizedBox(height: 30),
          const HomeTitle(title: 'Meu programa de treinamento'),
          MyTrainingPlanWidget(workoutSheets: homeScreenModel.myTrainingPlan),
          const SizedBox(height: 45),
          const HomeTitle(title: 'Todos os meus treinos'),
          const SizedBox(height: 15),
          AllMyWorkoutSheets(myWorkousheets: homeScreenModel.myWorkousheets)
        ],
      ),
    );
  }
}
