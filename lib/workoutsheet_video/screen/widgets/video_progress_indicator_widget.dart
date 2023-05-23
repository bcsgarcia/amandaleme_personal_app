import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWithProgressIndicator extends StatefulWidget {
  const VideoPlayerWithProgressIndicator({Key? key, required this.videoUrl}) : super(key: key);

  final String videoUrl;

  @override
  _VideoPlayerWithProgressIndicatorState createState() => _VideoPlayerWithProgressIndicatorState();
}

class _VideoPlayerWithProgressIndicatorState extends State<VideoPlayerWithProgressIndicator> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
              VideoProgressIndicator(
                _controller,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Colors.red,
                  bufferedColor: Colors.green,
                  backgroundColor: Colors.grey,
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _controller.value.isPlaying ? _controller.pause() : _controller.play();
                  });
                },
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
