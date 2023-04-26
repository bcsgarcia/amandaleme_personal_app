import 'package:flutter/material.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import 'widgets.dart';

class AllMyWorkoutSheets extends StatelessWidget {
  const AllMyWorkoutSheets({super.key, required this.myWorkousheets});

  final List<WorkoutSheetModel> myWorkousheets;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: myWorkousheets.length,
        itemBuilder: (context, i) {
          var item = myWorkousheets[i];
          return OptionWorkoutSheet(workoutSheet: item);
        },
      ),
    );
  }
}
