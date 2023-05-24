import 'package:amandaleme_personal_app/home/home.page.dart';
import 'package:amandaleme_personal_app/workoutsheet_video/cubit/workoutsheet_video_cubit.dart';
import 'package:amandaleme_personal_app/workoutsheets/screen/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:sync_repository/sync_repository.dart';
import 'package:video_preparation_service/video_preparation_service.dart';
import 'package:workoutsheet_repository/workoutsheet_repository.dart';

import '../app/app_route.dart';
import '../app/common_widgets/common_widgets.dart';
import '../home/cubit/home_cubit/home_cubit.dart';
import '../workoutsheet_video/workoutsheet_video_page.dart';
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

  bool showFloatingButton = true;

  late WorkoutsheetCubit cubit;

  verifyIfWorkoutHasBeenDone() {
    if (_workoutSheet.date != null) {
      showFloatingButton = false;
      for (var element in _workoutSheet.workouts) {
        element.done = true;
      }
    } else {
      for (var element in _workoutSheet.workouts) {
        element.done = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    cubit = WorkoutsheetCubit(context.read<WorkoutsheetRepository>());
    verifyIfWorkoutHasBeenDone();
  }

  onCompleteWorkoutsheetTap() {
    cubit.workoutsheetDone(_workoutSheet.id);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialogWidget(
          title: 'Parabéns!',
          description: 'Estamos um passo mais perto de alcançar nossos objetivos. Nos vemos no próximo treino!',
          buttonLabel: 'Voltar à página inicial',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => HomeCubit(
                    homeRepository: RepositoryProvider.of<IHomeRepository>(context),
                    syncRepository: RepositoryProvider.of<SyncRepository>(context),
                  ),
                  child: HomePage(
                    isShowFeedback: true,
                  ),
                ),
              ),
              ModalRoute.withName(RouteNames.home),
            );
          },
        );
      },
    );
  }

  void _showFailureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          buttonPressed: () {
            Navigator.of(context).pop();
            onCompleteWorkoutsheetTap();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<WorkoutsheetCubit, WorkoutsheetPageState>(
        bloc: cubit,
        builder: (context, state) {
          if (showFloatingButton && state.status != WorkoutsheetPageStatus.loadInProgress) {
            if (state.status == WorkoutsheetPageStatus.complete) {
              return WorkoutFloatingButton(
                title: 'Finalizar treino',
                function: onCompleteWorkoutsheetTap,
              );
            } else {
              return WorkoutFloatingButton(
                title: 'Iniciar treino',
                function: () {
                  final nextUncheckedWorkout = _workoutSheet.workouts.indexWhere((element) => element.done == false);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => WorkoutsheetVideoCubit(
                          videoPreparationService: context.read<VideoPreparationService>(),
                          workoutsheetRepository: context.read<WorkoutsheetRepository>(),
                        ),
                        child: WorkoutsheetVideoPage(workoutsheet: _workoutSheet, startWorkoutIndex: nextUncheckedWorkout),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Container();
          }
        },
      ),
      body: BlocProvider<WorkoutsheetCubit>(
        create: (_) => cubit,
        child: BlocListener<WorkoutsheetCubit, WorkoutsheetPageState>(
          listener: (context, state) {
            if (state.status == WorkoutsheetPageStatus.loadSuccess) {
              _showSuccessDialog();
            }
            if (state.status == WorkoutsheetPageStatus.loadFailure) {
              _showFailureDialog();
            }
          },
          child: BlocBuilder<WorkoutsheetCubit, WorkoutsheetPageState>(
            builder: (context, state) {
              if (state.status == WorkoutsheetPageStatus.loadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return WorkoutsheetScreen(
                  workoutsheet: _workoutSheet,
                );
              }
            },
          ),
        ),
      ),
    );
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
        onPressed: function,
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
