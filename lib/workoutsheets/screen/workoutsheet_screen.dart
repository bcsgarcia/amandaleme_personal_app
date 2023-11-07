import 'package:amandaleme_personal_app/workoutsheet_video/workoutsheet_video_page.dart';
import 'package:amandaleme_personal_app/workoutsheets/cubit/workoutsheet_cubit.dart';
import 'package:amandaleme_personal_app/workoutsheets/screen/widgets/workout_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:video_preparation_service/video_preparation_service.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../../app/common_widgets/common_widgets.dart';
import '../../home/cubit/home_cubit/cubit.dart';
import '../../workoutsheet_video/cubit/workoutsheet_video_cubit.dart';

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
    if (context.read<SyncCubit>().state.status == SyncStatus.loadInProgress) {
      const snackBar = SnackBar(
        content: Text('Aguarde o download dos treinos terminar!'),
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

              print(item);

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
