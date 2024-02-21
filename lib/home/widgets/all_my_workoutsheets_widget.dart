import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../../lib.dart';

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
