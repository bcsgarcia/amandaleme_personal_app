import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../app/theme/light_theme.dart';

class VideoProgressBarIndicatorWidget extends StatelessWidget {
  const VideoProgressBarIndicatorWidget({
    super.key,
    required VideoPlayerController controller,
  }) : _controller = controller;

  final VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[800]!.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            padding: EdgeInsets.zero,
            colors: const VideoProgressColors(
              playedColor: primaryColor,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
