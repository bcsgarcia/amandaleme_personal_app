import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:home_repository/home_repository.dart';

import '../../../app/common_widgets/box_shadow_default.dart';

class WorkoutItem extends StatefulWidget {
  const WorkoutItem({
    super.key,
    required this.workout,
    required this.funcDone,
  });

  final WorkoutModel workout;
  final void Function() funcDone;

  @override
  State<WorkoutItem> createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  WorkoutModel get _workout => widget.workout;
  Function() get _funcDone => widget.funcDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                _workout.medias.firstWhere((element) => element.type == 'image').url,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    _workout.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: _workout.done ? TextDecoration.lineThrough : null,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Série: ${_workout.serie}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          decoration: _workout.done ? TextDecoration.lineThrough : null,
                        ),
                  ),
                  Text(
                    'Descanso: ${_workout.breaktime.toString()}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          decoration: _workout.done ? TextDecoration.lineThrough : null,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: _workout.done
                ? GestureDetector(
                    onTap: _funcDone,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          defaultBoxShadow(),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: _funcDone,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          defaultBoxShadow(),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
