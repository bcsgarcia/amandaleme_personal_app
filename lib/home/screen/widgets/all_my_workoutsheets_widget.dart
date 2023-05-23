import 'package:amandaleme_personal_app/workoutsheets/workoutsheet_page.dart';
import 'package:flutter/material.dart';
import 'package:home_repository/home_repository.dart';

import 'widgets.dart';

class AllMyWorkoutSheets extends StatelessWidget {
  const AllMyWorkoutSheets({super.key, required this.myWorkousheets});

  final List<WorkoutSheetModel> myWorkousheets;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(
        myWorkousheets.length,
        (index) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutsheetPage(workoutSheet: myWorkousheets[index]),
            ),
          ),
          child: OptionWorkoutSheet(workoutSheet: myWorkousheets[index]),
        ),
      ),
    );
  }
}
