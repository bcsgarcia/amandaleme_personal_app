import 'package:flutter/material.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../../../app/common_widgets/common_widgets.dart';

class OptionWorkoutSheet extends StatelessWidget {
  const OptionWorkoutSheet({super.key, required this.workoutSheet});

  final WorkoutSheetModel workoutSheet;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      height: 49,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          defaultBoxShadow(),
        ],
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Text(
                workoutSheet.name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Icon(
              Icons.chevron_right_outlined,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
