import 'dart:math';

import 'package:flutter/material.dart';
import 'package:home_repository/home_repository.dart';
import 'package:video_player/video_player.dart';

import '../utils/utils.dart';

class WorkoutsheetVideoScreen extends StatefulWidget {
  const WorkoutsheetVideoScreen({
    super.key,
    required this.workout,
    required this.nextButtonFunction,
    required this.previousButtonFunction,
    required this.isShowPlay,
    required this.subTitle,
    required this.description,
    required this.videoPlayerController,
  });

  final WorkoutModel workout;
  final void Function()? nextButtonFunction;
  final void Function()? previousButtonFunction;
  final bool isShowPlay;
  final String subTitle;
  final String description;
  final VideoPlayerController videoPlayerController;

  @override
  State<WorkoutsheetVideoScreen> createState() => _WorkoutsheetVideoScreenState();
}

class _WorkoutsheetVideoScreenState extends State<WorkoutsheetVideoScreen> {
  WorkoutModel get _workout => widget.workout;

  void Function()? get _nextButtonFunction => widget.nextButtonFunction;
  void Function()? get _previousButtonFunction => widget.previousButtonFunction;
  bool get _isShowPlay => widget.isShowPlay;

  String get _subTitle => widget.subTitle;
  String get _description => widget.description;

  VideoPlayerController get _videoPlayerController => widget.videoPlayerController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.workout.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: 21,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
        ),
      ),
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Serie: ${_workout.serie}'),
              Row(
                children: [
                  Text('Descanso: ${_workout.breaktime}'),
                  const Spacer(),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/icons/comment.png',
                        height: 18,
                      ),
                      const SizedBox(width: 8),
                      const Text('Comentar'),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1.5),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: VideoPlayer(_videoPlayerController),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: BottomWorkoutBar(
                          nextButtonFunction: _nextButtonFunction,
                          previousButtonFunction: _previousButtonFunction,
                          isShowPlay: _isShowPlay,
                          subTitle: _subTitle,
                          description: _description,
                          controller: _videoPlayerController,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class BottomWorkoutBar extends StatefulWidget {
  const BottomWorkoutBar({
    super.key,
    required this.nextButtonFunction,
    required this.previousButtonFunction,
    required this.isShowPlay,
    required this.subTitle,
    required this.description,
    required this.controller,
  });

  final void Function()? nextButtonFunction;
  final void Function()? previousButtonFunction;
  final bool isShowPlay;
  final String subTitle;
  final String description;
  final VideoPlayerController controller;

  @override
  State<BottomWorkoutBar> createState() => _BottomWorkoutBarState();
}

class _BottomWorkoutBarState extends State<BottomWorkoutBar> {
  void Function()? get _nextButtonFunction => widget.nextButtonFunction;
  void Function()? get _previousButtonFunction => widget.previousButtonFunction;

  bool get _isShowPlay => widget.isShowPlay;

  String get _subTitle => widget.subTitle;
  String get _description => widget.description;

  VideoPlayerController get _controller => widget.controller;

  void _playVideo() {
    _controller.play();
    setState(() {});
  }

  void _pauseVideo() {
    _controller.pause();
    setState(() {});
  }

  void _resetVideo() {
    _controller.seekTo(const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    bool isPlaying = _controller.value.isPlaying;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (isPlaying && details.delta.dy < 0) {
          _pauseVideo();
        } else if (!isPlaying && details.delta.dy > 0) {
          _playVideo();
        }
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: isPlaying ? 105 : calculateSubtitleAndDescHeight(_subTitle, _description, context),
          // height: isPlaying ? 105 : 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: isPlaying ? Colors.white.withOpacity(0.3) : Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isPlaying == false)
                  SubTitleAndDescription(
                    subTitle: _subTitle,
                    description: _description,
                  ),
                if (isPlaying)
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: _previousButtonFunction == null || isPlaying
                            ? Container()
                            : PreviousVideoButton(
                                function: () {
                                  _previousButtonFunction!();
                                  _resetVideo();
                                },
                              ),
                      ),
                      PlayerButton(
                        controller: _controller,
                        play: _playVideo,
                        pause: _pauseVideo,
                      ),
                      Expanded(
                        child: _nextButtonFunction == null || isPlaying
                            ? Container()
                            : NextVideoButton(
                                function: () {
                                  _nextButtonFunction!();
                                  _resetVideo();
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
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
    return Expanded(
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child: ListTile(
                title: Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16, height: 1.5),
                  ),
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
    required this.controller,
    required this.play,
    required this.pause,
  });

  final VideoPlayerController controller;
  final void Function() play;
  final void Function() pause;

  bool get isPlaying => controller.value.isPlaying;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPlaying ? pause : play,
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
        children: [Transform.rotate(angle: pi, child: Image.asset('assets/images/icons/next-right.png', height: 30)), const Text('Voltar')],
      ),
    );
  }
}
