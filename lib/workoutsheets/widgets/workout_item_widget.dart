import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

import '../../lib.dart';

class WorkoutItem extends StatefulWidget {
  const WorkoutItem({
    super.key,
    required this.workout,
    required this.funcDone,
    required this.isAlreadyDone,
  });

  final WorkoutModel workout;
  final bool isAlreadyDone;
  final void Function() funcDone;

  @override
  State<WorkoutItem> createState() => _WorkoutItemState();
}

class _WorkoutItemState extends State<WorkoutItem> {
  WorkoutModel get _workout => widget.workout;
  Function() get _funcDone => widget.funcDone;
  bool get _isAlreadyDone => widget.isAlreadyDone;

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
              child: _workout.medias.isEmpty
                  ? const SizedBox.shrink()
                  : Image.network(
                      _workout.medias.first.type == 'image'
                          ? _workout.medias.first.url
                          : _workout.medias.first.thumbnailUrl ?? '',
                      fit: BoxFit.cover,
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
                    'Descanso: ${_workout.breaktime}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          decoration: _workout.done ? TextDecoration.lineThrough : null,
                        ),
                  ),
                ],
              ),
            ),
          ),
          if (!_isAlreadyDone)
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
