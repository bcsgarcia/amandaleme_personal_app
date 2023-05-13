import 'package:amandaleme_personal_app/workoutsheets/screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';

import 'cubit/workoutsheet_cubit.dart';

class WorkoutsheetPage extends StatefulWidget {
  const WorkoutsheetPage({
    super.key,
    required this.workoutSheet,
  });

  final WorkoutSheetModel workoutSheet;

  @override
  State<WorkoutsheetPage> createState() => _WorkoutsheetPageState();
}

class _WorkoutsheetPageState extends State<WorkoutsheetPage> {
  WorkoutSheetModel get _workoutSheet => widget.workoutSheet;

  final workoutsheetCubit = WorkoutsheetCubit();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            BlocBuilder<WorkoutsheetCubit, WorkoutsheetPageState>(
          bloc: workoutsheetCubit,
          builder: (context, state) {
            if (state.status == WorkoutsheetPageStatus.complete) {
              return WorkoutFloatingButton(
                  title: 'Finalizar treino', function: () {});
            } else {
              return WorkoutFloatingButton(
                  title: 'Iniciar treino', function: () {});
            }
          },
        ),
        body: BlocProvider<WorkoutsheetCubit>(
          create: (_) => workoutsheetCubit,
          child: WorkoutsheetScreen(
            workoutsheet: _workoutSheet,
          ),
        ),
      );
    });
  }
}

class WorkoutFloatingButton extends StatelessWidget {
  const WorkoutFloatingButton({
    super.key,
    required this.title,
    required this.function,
  });

  final String title;
  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 223,
      child: FloatingActionButton.extended(
        onPressed: () {},
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14.0),
          ),
        ),
        label: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
