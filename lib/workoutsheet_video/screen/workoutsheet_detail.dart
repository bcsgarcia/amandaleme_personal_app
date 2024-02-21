import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:workout_repository/workout_repository.dart';

import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class WorkoutsheetDetail extends StatefulWidget {
  const WorkoutsheetDetail({super.key});

  @override
  State<WorkoutsheetDetail> createState() => _WorkoutsheetDetailState();
}

class _WorkoutsheetDetailState extends State<WorkoutsheetDetail> {
  VideoPlayerController? videoPlayerController;

  late WorkoutsheetDetailCubit _cubit;
  double volume = 1;

  @override
  void initState() {
    super.initState();

    _cubit = context.read<WorkoutsheetDetailCubit>();

    _setVideoPlayerControllerFile(
      _cubit.state.currentVideoFile,
      VideoAction.pause,
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();

    super.dispose();
  }

  void _setVideoPlayerControllerFile(File file, VideoAction videoAction) async {
    videoPlayerController?.dispose();
    videoPlayerController = VideoPlayerController.file(file);
    await videoPlayerController?.initialize();
    await videoPlayerController?.setVolume(volume);
    await videoPlayerController?.seekTo(Duration.zero);
    videoPlayerController?.addListener(() {
      final position = videoPlayerController?.value.position.inSeconds.toDouble() ?? 0;
      final duration = videoPlayerController?.value.duration.inSeconds.toDouble() ?? 0;
      _cubit.updateProgress(position / duration);
    });

    if (videoAction == VideoAction.next || videoAction == VideoAction.previous) {
      _cubit.onPause();
    }

    if (videoAction == VideoAction.nextVideo || videoAction == VideoAction.previousVideo) {
      await videoPlayerController?.play();
    }
  }

  void _openFeedbackDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider.value(
          value: WorkoutFeedbackCubit(context.read<WorkoutRepository>()),
          child: WorkoutFeedbackDialogWidget(
            workout: _cubit.state.workout,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkoutsheetDetailCubit, WorkoutsheetDetailState>(
      listener: (context, state) {
        if (state.videoAction == VideoAction.play && state.progress == 1.0) {
          _cubit.onNextWorkoutVideo();
        }
      },
      child: BlocBuilder<WorkoutsheetDetailCubit, WorkoutsheetDetailState>(
        builder: (context, state) {
          if (state.videoAction == VideoAction.next ||
              state.videoAction == VideoAction.previous ||
              state.videoAction == VideoAction.nextVideo ||
              state.videoAction == VideoAction.previousVideo) {
            _setVideoPlayerControllerFile(state.currentVideoFile, state.videoAction);
          }

          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: Text(
                state.workout.title,
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Serie: ${state.workout.serie}'),
                      Row(
                        children: [
                          Text('Descanso: ${state.workout.breaktime}'),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => _openFeedbackDialog(),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/icons/comment.png',
                                  height: 18,
                                ),
                                const SizedBox(width: 8),
                                const Text('Comentar'),
                              ],
                            ),
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
                                child: videoPlayerController != null
                                    ? VideoPlayer(videoPlayerController!)
                                    : const SizedBox.shrink(),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                                height: 14,
                                width: double.infinity,
                                child: Row(
                                  children: List<Widget>.generate(
                                    state.allWorkoutVideoModel
                                        .firstWhere((e) => e.idWorkout == state.workout.id)
                                        .mediaFileList
                                        .length,
                                    (index) => Expanded(
                                      child: Padding(
                                        padding: state.allWorkoutVideoModel
                                                    .firstWhere((e) => e.idWorkout == state.workout.id)
                                                    .mediaFileList
                                                    .length >
                                                1
                                            ? const EdgeInsets.only(left: 9)
                                            : EdgeInsets.zero,
                                        child: videoPlayerController != null
                                            ? LinearProgressIndicator(
                                                value: index == state.currentWorkoutVideoIndex
                                                    ? state.progress
                                                    : index > state.currentWorkoutVideoIndex
                                                        ? 0
                                                        : 1)
                                            // VideoProgressIndicator(
                                            //     videoPlayerController!,
                                            //     allowScrubbing: false,
                                            //     colors: const VideoProgressColors(
                                            //       playedColor: primaryColor,
                                            //       bufferedColor: Colors.grey,
                                            //       backgroundColor: Colors.grey,
                                            //     ),
                                            //   )
                                            : const SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                child: GestureDetector(
                                  onTap: () => context.read<WorkoutsheetDetailCubit>().onPreviousWorkoutVideo(),
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
                                  onTap: () => _cubit.onNextWorkoutVideo(),
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
                                top: 30,
                                right: 15,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.4),
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      final double newVolume = videoPlayerController?.value.volume == 0 ? 1 : 0;

                                      await videoPlayerController?.setVolume(newVolume);
                                      setState(() {
                                        volume = newVolume;
                                      });
                                    },
                                    icon: Icon(
                                        videoPlayerController?.value.volume == 0 ? Icons.volume_off : Icons.volume_up),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  height: videoPlayerController?.value.isPlaying ?? false ? null : 300,
                                  child: BottomWorkoutBar(
                                    nextButtonFunction: state.isLastWorkout ? null : () => _cubit.onNextWorkout(),
                                    previousButtonFunction:
                                        state.isFirstWorkout ? null : () => _cubit.onPreviousWorkout(),
                                    subTitle: state.workout.subtitle,
                                    description: state.workout.description,
                                    isVideoPlaying: videoPlayerController?.value.isPlaying ?? false,
                                    playVideoFunction: () {
                                      videoPlayerController?.play();
                                      setState(() {});
                                    },
                                    pauseVideoFunction: () {
                                      videoPlayerController?.pause();
                                      setState(() {});
                                    },
                                    concludeWorkoutsheetFunction: state.isLastWorkout
                                        ? () => context
                                            .read<WorkoutsheetVideoCubit>()
                                            .workoutsheetDone(state.workoutsheet.id)
                                        : null, // _concludeWorkoutsheetFunction,
                                  ),
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
        },
      ),
    );
  }
}
