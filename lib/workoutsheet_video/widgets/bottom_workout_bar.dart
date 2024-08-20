import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/app.dart';
import '../utils/utils.dart';

class BottomWorkoutBar extends StatefulWidget {
  const BottomWorkoutBar({
    super.key,
    required this.nextButtonFunction,
    required this.previousButtonFunction,
    required this.playVideoFunction,
    required this.pauseVideoFunction,
    required this.isVideoPlaying,
    required this.subTitle,
    required this.description,
    required this.concludeWorkoutsheetFunction,
  });

  final void Function()? nextButtonFunction;
  final void Function()? previousButtonFunction;
  final void Function()? playVideoFunction;
  final void Function()? pauseVideoFunction;
  final void Function()? concludeWorkoutsheetFunction;

  final bool isVideoPlaying;
  final String subTitle;
  final String description;

  @override
  State<BottomWorkoutBar> createState() => _BottomWorkoutBarState();
}

class _BottomWorkoutBarState extends State<BottomWorkoutBar> {
  void Function()? get _nextButtonFunction => widget.nextButtonFunction;
  void Function()? get _previousButtonFunction => widget.previousButtonFunction;
  void Function()? get _concludeWorkoutsheetFunction => widget.concludeWorkoutsheetFunction;

  void Function()? get _playVideoFunction => widget.playVideoFunction;
  void Function()? get _pauseVideoFunction => widget.pauseVideoFunction;

  String get _subTitle => widget.subTitle;
  String get _description => widget.description;

  bool get _isVideoPlaying => widget.isVideoPlaying;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (_isVideoPlaying && details.delta.dy < 0) {
          _pauseVideoFunction!();
        } else if (!_isVideoPlaying && details.delta.dy > 0) {
          _playVideoFunction!();
        }
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _isVideoPlaying ? 105 : calculateSubtitleAndDescHeight(_subTitle, _description, context),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: _isVideoPlaying ? Colors.white.withOpacity(0.3) : Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!_isVideoPlaying)
                SubTitleAndDescription(
                  subTitle: _subTitle,
                  description: _description,
                ),
              if (_isVideoPlaying)
                Center(
                  child: Container(
                    width: 100,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _previousButtonFunction == null || _isVideoPlaying
                        ? Container()
                        : PreviousVideoButton(
                            function: () {
                              _previousButtonFunction!();
                            },
                          ),
                  ),
                  PlayerButton(
                    isPlaying: _isVideoPlaying,
                    playVideoFunction: _playVideoFunction,
                    pauseVideoFunction: _pauseVideoFunction,
                  ),
                  if (_concludeWorkoutsheetFunction == null && _nextButtonFunction != null && !_isVideoPlaying)
                    Expanded(
                      child: NextVideoButton(
                        function: () {
                          _nextButtonFunction!();
                        },
                      ),
                    ),
                  if (_concludeWorkoutsheetFunction != null && !_isVideoPlaying)
                    ConcludeWorkoutButton(
                      concludeWorkoutsheetFunction: _concludeWorkoutsheetFunction,
                    ),
                  if (_isVideoPlaying) Expanded(child: Container())
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubTitleAndDescription extends StatelessWidget {
  const SubTitleAndDescription({
    super.key,
    required this.subTitle,
    required this.description,
  });

  final String subTitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        subTitle,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          description,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16, height: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerButton extends StatelessWidget {
  const PlayerButton({
    super.key,
    required this.isPlaying,
    required this.playVideoFunction,
    required this.pauseVideoFunction,
  });

  final bool isPlaying;
  final VoidCallback? playVideoFunction;
  final VoidCallback? pauseVideoFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPlaying ? pauseVideoFunction : playVideoFunction,
      child: Container(
        height: 70,
        width: 70,
        padding: isPlaying ? EdgeInsets.zero : const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: isPlaying ? Colors.white.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(70),
          border: Border.all(),
        ),
        child: Center(
          child: Image.asset(
            isPlaying ? 'assets/images/icons/pause.png' : 'assets/images/icons/play.png',
            height: 30,
          ),
        ),
      ),
    );
  }
}

class NextVideoButton extends StatelessWidget {
  const NextVideoButton({
    super.key,
    required this.function,
  });

  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset('assets/images/icons/next-right.png', height: 30), const Text('Avançar')],
      ),
    );
  }
}

class PreviousVideoButton extends StatelessWidget {
  const PreviousVideoButton({
    super.key,
    required this.function,
  });

  final void Function()? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(angle: pi, child: Image.asset('assets/images/icons/next-right.png', height: 30)),
          const Text('Voltar')
        ],
      ),
    );
  }
}

class ConcludeWorkoutButton extends StatelessWidget {
  const ConcludeWorkoutButton({super.key, required this.concludeWorkoutsheetFunction});

  final void Function()? concludeWorkoutsheetFunction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: successColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: concludeWorkoutsheetFunction,
          child: Text(
            'Concluir',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
