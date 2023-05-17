import 'package:amandaleme_personal_app/workoutsheets/cubit/workoutsheet_cubit.dart';
import 'package:amandaleme_personal_app/workoutsheets/screen/widgets/workout_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';

import '../../app/common_widgets/common_widgets.dart';

class WorkoutsheetScreen extends StatefulWidget {
  const WorkoutsheetScreen({
    super.key,
    required this.workoutsheet,
  });

  final WorkoutSheetModel workoutsheet;

  @override
  State<WorkoutsheetScreen> createState() => _WorkoutsheetScreenState();
}

class _WorkoutsheetScreenState extends State<WorkoutsheetScreen> {
  WorkoutSheetModel get _workoutSheet => widget.workoutsheet;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderWithTitleLeadinAndAction(
          title: _workoutSheet.name,
          leadingButton: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 0.0, bottom: 120),
            separatorBuilder: (context, i) => const Divider(),
            itemCount: _workoutSheet.workouts.length,
            itemBuilder: (context, i) {
              final item = _workoutSheet.workouts[i];
              return WorkoutItem(
                workout: item,
                funcDone: () {
                  item.done = !item.done;
                  if (_workoutSheet.workouts.every((element) => element.done)) {
                    context.read<WorkoutsheetCubit>().workoutsheetComplete();
                  } else {
                    context.read<WorkoutsheetCubit>().workoutsheetIncomplete();
                  }
                  setState(() {});
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
