import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_repository/home_repository.dart';
import 'package:video_player/video_player.dart';

import '../../app/theme/light_theme.dart';
import '../cubit/workoutsheet_video_cubit.dart';
import '../utils/utils.dart';

class WorkoutsheetVideoScreen extends StatefulWidget {
  const WorkoutsheetVideoScreen({
    super.key,
    required this.workout,
    required this.subTitle,
    required this.description,
    required this.videoPlayerController,
    required this.isCurrentVideoPlaying,
    required this.indexCurrentWorkoutVideo,
    required this.nextButtonFunction,
    required this.previousButtonFunction,
    required this.concludeWorkoutsheetFunction,
  });

  final WorkoutModel workout;
  final String subTitle;
  final String description;
  final List<VideoPlayerController> videoPlayerController;
  final bool isCurrentVideoPlaying;
  final int indexCurrentWorkoutVideo;

  final void Function()? nextButtonFunction;
  final void Function()? previousButtonFunction;
  final void Function()? concludeWorkoutsheetFunction;

  @override
  State<WorkoutsheetVideoScreen> createState() => _WorkoutsheetVideoScreenState();
}

class _WorkoutsheetVideoScreenState extends State<WorkoutsheetVideoScreen> {
  WorkoutModel get _workout => widget.workout;

  String get _subTitle => widget.subTitle;
  String get _description => widget.description;

  void Function()? get _nextButtonFunction => widget.nextButtonFunction;
  void Function()? get _previousButtonFunction => widget.previousButtonFunction;
  void Function()? get _concludeWorkoutsheetFunction => widget.concludeWorkoutsheetFunction;

  List<VideoPlayerController> get _videoPlayerController => widget.videoPlayerController;

  bool get _isCurrentVideoPlaying => widget.isCurrentVideoPlaying;

  int get _currentVideoIndex => widget.indexCurrentWorkoutVideo;

  late WorkoutsheetVideoCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<WorkoutsheetVideoCubit>();
  }

  void addListener() {
    for (var controller in _videoPlayerController) {
      controller.addListener(checkIfVideoHasEnded);
      setState(() {});
    }
  }

  void checkIfVideoHasEnded() {
    final currentVideo = _videoPlayerController[cubit.state.currentWorkoutVideoIndex];
    final currentVideoIndex = cubit.state.currentWorkoutVideoIndex;

    final nextVideoIndex = currentVideoIndex + 1;

    final videoHasEnded = currentVideo.value.position == currentVideo.value.duration;
    final allVideosOfWorkout = _videoPlayerController;

    if (videoHasEnded) {
      if (currentVideoIndex < allVideosOfWorkout.length - 1) {
        currentVideo.pause;
        allVideosOfWorkout[nextVideoIndex].play();

        cubit.playNextVideoOfTheCurrentWorkout();
      } else {
        cubit.resetAllVideosOfWorkout();
        cubit.pauseAllVideosOfWorkout();
        cubit.updatePageState(0, false);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    addListener();

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          child: VideoPlayer(_videoPlayerController[_currentVideoIndex]),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                          height: 14,
                          width: double.infinity,
                          child: Row(
                            children: List<Widget>.generate(
                              _videoPlayerController.length,
                              (index) => Expanded(
                                child: Padding(
                                  padding: _videoPlayerController.length > 1 ? const EdgeInsets.only(left: 9) : EdgeInsets.zero,
                                  child: VideoProgressIndicator(
                                    _videoPlayerController[index],
                                    allowScrubbing: false,
                                    colors: const VideoProgressColors(
                                      playedColor: primaryColor,
                                      bufferedColor: Colors.grey,
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: GestureDetector(
                            onTap: cubit.playPreviousVideoOfTheCurrentWOrkout,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: cubit.playNextVideoOfTheCurrentWorkout,
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: BottomWorkoutBar(
                            nextButtonFunction: _nextButtonFunction,
                            previousButtonFunction: _previousButtonFunction,
                            subTitle: _subTitle,
                            description: _description,
                            isVideoPlaying: _isCurrentVideoPlaying,
                            playVideoFunction: cubit.playCurrentVideo,
                            pauseVideoFunction: cubit.pauseCurrentVideo,
                            concludeWorkoutsheetFunction: _concludeWorkoutsheetFunction,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

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
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: _isVideoPlaying ? 105 : calculateSubtitleAndDescHeight(_subTitle, _description, context),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: _isVideoPlaying ? Colors.white.withOpacity(0.3) : Colors.white,
            border: Border.all(),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_isVideoPlaying == false)
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
    required this.isPlaying,
  });

  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPlaying ? context.read<WorkoutsheetVideoCubit>().pauseCurrentVideo : context.read<WorkoutsheetVideoCubit>().playCurrentVideo,
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
