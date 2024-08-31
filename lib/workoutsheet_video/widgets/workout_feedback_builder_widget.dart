import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../../app/theme/light_theme.dart';
import '../cubit/workout_feedback_cubit.dart';

class WorkoutFeedbackDialogWidget extends StatefulWidget {
  const WorkoutFeedbackDialogWidget({
    super.key,
    required this.workout,
  });

  final WorkoutModel workout;

  @override
  State<WorkoutFeedbackDialogWidget> createState() => _WorkoutFeedbackDialogWidgetState();
}

class _WorkoutFeedbackDialogWidgetState extends State<WorkoutFeedbackDialogWidget> {
  WorkoutModel get _workout => widget.workout;

  final textController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    textController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    context.read<WorkoutFeedbackCubit>().createFeedback(_workout.id);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = textController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutFeedbackCubit, WorkoutFeedbackState>(
      listener: (context, state) {
        if (state.status == WorkoutFeedbackStatus.loadSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('Feedback enviado.'),
                backgroundColor: successColor,
              ),
            );
          Navigator.pop(context);
        }
      },
      child: ScaffoldMessenger(
        child: Builder(builder: (context) {
          return BlocListener<WorkoutFeedbackCubit, WorkoutFeedbackState>(
            listener: (context, state) {
              if (state.status == WorkoutFeedbackStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Erro ao enviar feedback. Tente novamente.'),
                      backgroundColor: errorColor,
                    ),
                  );
              }
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SimpleDialog(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                children: [
                  const SizedBox(height: 23),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Feedback',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 23),
                  Text(
                    'Qual seu comentário para o exercicio \n"${_workout.title}"?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  WorkoutFeedbackTextEntryBox(textController: textController),
                  BlocBuilder<WorkoutFeedbackCubit, WorkoutFeedbackState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          state.status == WorkoutFeedbackStatus.loadInProgress
                              ? Container()
                              : TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Cancelar',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                  ),
                                ),
                          const SizedBox(width: 8),
                          state.status == WorkoutFeedbackStatus.loadInProgress
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  height: 41,
                                  width: 110,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isButtonEnabled ? successColor : Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: isButtonEnabled ? submitFeedback : null,
                                    child: FittedBox(
                                      child: Text(
                                        'Concluir',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 23),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class WorkoutFeedbackTextEntryBox extends StatelessWidget {
  const WorkoutFeedbackTextEntryBox({
    super.key,
    required this.textController,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 162,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: secondaryColor,
        ),
      ),
      child: TextFormField(
        controller: textController,
        maxLines: null,
        onChanged: (value) {
          context.read<WorkoutFeedbackCubit>().feedback = value;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          border: InputBorder.none,
          hintText: 'Digite aqui seu feedback...',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
