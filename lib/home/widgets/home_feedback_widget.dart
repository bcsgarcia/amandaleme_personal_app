import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../../lib.dart';

class HomeFeedbackWidget extends StatelessWidget {
  const HomeFeedbackWidget({
    super.key,
    required this.workout,
  });

  final WorkoutSheetModel workout;

  @override
  Widget build(BuildContext context) {
    void showFeedbackDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return BlocProvider.value(
            value: context.read<FeedbackCubit>(),
            child: FeedbackDialogWidget(
              workoutsheet: workout,
            ),
          );
        },
      );
    }

    void showDialogError(FeedbackCubit cubit) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(
            buttonPressed: () {
              cubit.createFeedback(workout.id);
              Navigator.pop(context);
            },
          );
        },
      );
    }

    return BlocListener<FeedbackCubit, FeedbackState>(
      listener: (context, state) {
        if (state.status == FeedbackStatus.failure) {
          showDialogError(context.read<FeedbackCubit>());
        }
      },
      child: BlocBuilder<FeedbackCubit, FeedbackState>(
        builder: (context, state) {
          if (state.status == FeedbackStatus.initial) {
            return FeedbackWidget(
              text: 'Gostaria de deixar um feedback sobre o treino de hoje?',
              function: showFeedbackDialog,
            );
          }

          if (state.status == FeedbackStatus.loadSuccess) {
            return const FeedbackWidget(
              text: 'Feedback enviado!',
              height: 56,
            );
          }

          if (state.status == FeedbackStatus.loadInProgress) {
            return const FeedbackWidget(text: 'Enviando feedback...', isLoading: true, height: 56);
          }

          return const SizedBox(height: 20);
        },
      ),
    );
  }
}

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({super.key, required this.text, this.function, this.isLoading = false, this.height = 76});

  final String text;
  final void Function()? function;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: UnconstrainedBox(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 29),
          height: height,
          width: isLoading ? height : MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              if (!isLoading)
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
            ],
            color: isLoading ? Colors.white : const Color(0xffCCF0C6),
          ),
          child: Row(
            children: [
              if (isLoading)
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(color: primaryColor),
                  ),
                ),
              if (!isLoading)
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/icons/message-circle.png',
                          height: 24,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeedbackDialogWidget extends StatefulWidget {
  const FeedbackDialogWidget({
    super.key,
    required this.workoutsheet,
  });

  final WorkoutSheetModel workoutsheet;

  @override
  State<FeedbackDialogWidget> createState() => _FeedbackDialogWidgetState();
}

class _FeedbackDialogWidgetState extends State<FeedbackDialogWidget> {
  WorkoutSheetModel get _workoutSheet => widget.workoutsheet;

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
    Navigator.pop(context);

    context.read<FeedbackCubit>().createFeedback(_workoutSheet.id);
  }

  void updateButtonState() {
    setState(() {
      isButtonEnabled = textController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
                'Feedback - ${_workoutSheet.name}',
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
          'Qual seu comentário para o treino de hoje?',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
        ),
        HomeTextEntryBox(textController: textController),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
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
            SizedBox(
              height: 41,
              width: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isButtonEnabled ? successColor : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: isButtonEnabled ? submitFeedback : null,
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
          ],
        ),
        const SizedBox(height: 23),
      ],
    );
  }
}

class HomeTextEntryBox extends StatelessWidget {
  const HomeTextEntryBox({
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
          context.read<FeedbackCubit>().textFeedback = value;
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
