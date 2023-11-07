// import 'dart:io';

// import 'package:amandaleme_personal_app/workoutsheet_video/screen/widgets/workout_feedback_builder_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:home_repository/home_repository.dart';
// import 'package:video_player/video_player.dart';
// import 'package:workout_repository/workout_repository.dart';

// import '../../app/theme/light_theme.dart';
// import '../cubit/workout_feedback_cubit.dart';
// import '../cubit/workoutsheet_video_cubit.dart';

// class WorkoutsheetVideoScreen extends StatefulWidget {
//   const WorkoutsheetVideoScreen({
//     super.key,
//     required this.workout,
//     required this.subTitle,
//     required this.description,
//     required this.videoPlayerControllerFiles,
//     required this.isCurrentVideoPlaying,
//     required this.indexCurrentWorkoutVideo,
//     required this.nextButtonFunction,
//     required this.previousButtonFunction,
//     required this.concludeWorkoutsheetFunction,
//   });

//   final WorkoutModel workout;
//   final String subTitle;
//   final String description;
//   final List<File> videoPlayerControllerFiles;
//   final bool isCurrentVideoPlaying;
//   final int indexCurrentWorkoutVideo;

//   final void Function()? nextButtonFunction;
//   final void Function()? previousButtonFunction;
//   final void Function()? concludeWorkoutsheetFunction;

//   @override
//   State<WorkoutsheetVideoScreen> createState() => _WorkoutsheetVideoScreenState();
// }

// class _WorkoutsheetVideoScreenState extends State<WorkoutsheetVideoScreen> {
//   WorkoutModel get _workout => widget.workout;

//   String get _subTitle => widget.subTitle;
//   String get _description => widget.description;

//   void Function()? get _nextButtonFunction => widget.nextButtonFunction;
//   void Function()? get _previousButtonFunction => widget.previousButtonFunction;
//   void Function()? get _concludeWorkoutsheetFunction => widget.concludeWorkoutsheetFunction;

//   List<File> get _videoPlayerControllerFiles => widget.videoPlayerControllerFiles;

//   late VideoPlayerController _videoPlayerController;

//   bool get _isCurrentVideoPlaying => widget.isCurrentVideoPlaying;

//   int get _currentVideoIndex => widget.indexCurrentWorkoutVideo;

//   late WorkoutsheetVideoCubit cubit;

//   @override
//   void initState() {
//     super.initState();
//     cubit = context.read<WorkoutsheetVideoCubit>();
//     _initController();
//   }

//   Future _initController() async {
//     _videoPlayerController = VideoPlayerController.file(_videoPlayerControllerFiles[_currentVideoIndex]);
//     await _videoPlayerController.initialize();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     try {
//       if (_videoPlayerController.value.isPlaying) {
//         _videoPlayerController.pause();
//       }
//     } catch (error) {
//       debugPrint(error.toString());
//     }

//     cubit.onDisposeVideos();
//   }

//   void addListener() {
//     // for (var controller in _videoPlayerController) {
//     _videoPlayerController.addListener(checkIfVideoHasEnded);
//     setState(() {});
//     // }
//   }

//   void checkIfVideoHasEnded() {
//     // final currentVideo = _videoPlayerController[cubit.state.currentWorkoutVideoIndex];
//     // final currentVideoIndex = cubit.state.currentWorkoutVideoIndex;

//     // final nextVideoIndex = currentVideoIndex + 1;

//     // final videoHasEnded = currentVideo.value.position == currentVideo.value.duration;
//     // final allVideosOfWorkout = _videoPlayerController;

//     // if (videoHasEnded) {
//     //   if (currentVideoIndex < allVideosOfWorkout.length - 1) {
//     //     currentVideo.pause;
//     //     allVideosOfWorkout[nextVideoIndex].play();

//     //     cubit.playNextVideoOfTheCurrentWorkout();
//     //   } else {
//     //     cubit.resetAllVideosOfWorkout();
//     //     cubit.pauseAllVideosOfWorkout();
//     //     cubit.updatePageState(0, false);
//     //   }
//     // }

//     // setState(() {});
//   }

//   void openFeedbackDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return BlocProvider.value(
//           value: WorkoutFeedbackCubit(context.read<WorkoutRepository>()),
//           child: WorkoutFeedbackDialogWidget(
//             workout: _workout,
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     addListener();

//     return BlocListener<WorkoutsheetVideoCubit, WorkoutsheetVideoPageState>(
//       listener: (context, state) {
//         print(state);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           systemOverlayStyle: SystemUiOverlayStyle.dark,
//           title: Text(
//             widget.workout.title,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                   fontSize: 21,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.close,
//               color: Colors.black,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         body: Builder(
//           builder: (context) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Text('Serie: ${_workout.serie}'),
//                   Row(
//                     children: [
//                       Text('Descanso: ${_workout.breaktime}'),
//                       const Spacer(),
//                       GestureDetector(
//                         onTap: openFeedbackDialog,
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/images/icons/comment.png',
//                               height: 18,
//                             ),
//                             const SizedBox(width: 8),
//                             const Text('Comentar'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(vertical: 15),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(40),
//                         border: Border.all(width: 1.5),
//                       ),
//                       child: Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(40),
//                             child: VideoPlayer(_videoPlayerController),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
//                             height: 14,
//                             width: double.infinity,
//                             child: Row(
//                               children: List<Widget>.generate(
//                                 _videoPlayerControllerFiles.length,
//                                 (index) => Expanded(
//                                   child: Padding(
//                                     padding: _videoPlayerControllerFiles.length > 1
//                                         ? const EdgeInsets.only(left: 9)
//                                         : EdgeInsets.zero,
//                                     child: VideoProgressIndicator(
//                                       _videoPlayerController,
//                                       allowScrubbing: false,
//                                       colors: const VideoProgressColors(
//                                         playedColor: primaryColor,
//                                         bufferedColor: Colors.grey,
//                                         backgroundColor: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             child: GestureDetector(
//                               onTap: cubit.playPreviousVideoOfTheCurrentWOrkout,
//                               child: Container(
//                                 height: MediaQuery.of(context).size.height,
//                                 width: MediaQuery.of(context).size.width / 4,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             right: 0,
//                             child: GestureDetector(
//                               onTap: cubit.playNextVideoOfTheCurrentWorkout,
//                               child: Container(
//                                 height: MediaQuery.of(context).size.height,
//                                 width: MediaQuery.of(context).size.width / 4,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             child: BottomWorkoutBar(
//                               nextButtonFunction: _nextButtonFunction,
//                               previousButtonFunction: _previousButtonFunction,
//                               subTitle: _subTitle,
//                               description: _description,
//                               isVideoPlaying: _isCurrentVideoPlaying,
//                               playVideoFunction: cubit.playCurrentVideo,
//                               pauseVideoFunction: cubit.pauseCurrentVideo,
//                               concludeWorkoutsheetFunction: _concludeWorkoutsheetFunction,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
