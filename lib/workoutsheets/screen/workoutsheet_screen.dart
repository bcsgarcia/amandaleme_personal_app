import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';
import 'package:video_preparation_service/video_preparation_service.dart';

import '../../lib.dart';

class WorkoutsheetScreen extends StatefulWidget {
  const WorkoutsheetScreen({
    super.key,
    required this.workoutsheet,
    required this.isAlreadyDone,
  });

  final WorkoutSheetModel workoutsheet;
  final bool isAlreadyDone;

  @override
  State<WorkoutsheetScreen> createState() => _WorkoutsheetScreenState();
}

class _WorkoutsheetScreenState extends State<WorkoutsheetScreen> {
  WorkoutSheetModel get _workoutSheet => widget.workoutsheet;

  bool get _isAlreadyDone => widget.isAlreadyDone;

  @override
  void initState() {
    super.initState();
  }

  _goToWorkoutSheetVideo(int index) {
    if (context.read<HomeSyncCubit>().state.status == SyncStatus.loadInProgress &&
        context.read<HomeSyncCubit>().state.percentage < 0.03) {
      final percentage = (context.read<HomeSyncCubit>().state.percentage * 100).toInt();
      final snackBar = SnackBar(
        content: Text('Download em andamento, aguarde um momento. $percentage%'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => WorkoutsheetVideoCubit(
            videoPreparationService: context.read<VideoPreparationService>(),
            workoutsheetRepository: context.read<WorkoutsheetRepository>(),
          ),
          child: WorkoutsheetVideoPage(
            workoutsheet: _workoutSheet,
            startWorkoutIndex: index,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 50.0, bottom: 120),
            separatorBuilder: (context, i) => const Divider(
              color: Colors.transparent,
            ),
            itemCount: _workoutSheet.workouts.length,
            itemBuilder: (context, i) {
              final item = _workoutSheet.workouts[i];

              return GestureDetector(
                onTap: () => _goToWorkoutSheetVideo(i),
                child: WorkoutItem(
                  workout: item,
                  isAlreadyDone: _isAlreadyDone,
                  funcDone: () {
                    item.done = !item.done;
                    if (_workoutSheet.workouts.every((element) => element.done)) {
                      context.read<WorkoutsheetCubit>().workoutsheetComplete();
                    } else {
                      context.read<WorkoutsheetCubit>().workoutsheetIncomplete();
                    }
                    setState(() {});
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
