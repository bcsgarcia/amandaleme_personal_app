import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../app/common_widgets/common_widgets.dart';
import '../../../app/theme/light_theme.dart';

class CompanyVideo extends StatefulWidget {
  const CompanyVideo({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<CompanyVideo> createState() => CompanyVideoState();
}

class CompanyVideoState extends State<CompanyVideo> {
  late VideoPlayerController _controller;

  String get _videoUrl => widget.videoUrl;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(_videoUrl)
      ..initialize().then((_) {
        setState(() {
          isLoading = false;
        });
      });
  }

  void startCompanyVideo() {
    _controller.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }

                setState(() {});
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: !isLoading
                            ? [
                                defaultBoxShadow(),
                              ]
                            : null,
                      ),
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (!_controller.value.isPlaying)
            Positioned(
              top: 65, // Adjust the position of the CircleAvatar widget
              left: 160,
              child: CircleAvatar(
                backgroundColor: whiteColor,
                radius: 20, // Control the radius of the CircleAvatar widget
                child: isLoading
                    ? CircularProgressIndicator(
                        color: primaryColor,
                      )
                    : IconButton(
                        onPressed: startCompanyVideo,
                        icon: const Icon(Icons.play_arrow_outlined),
                        color: primaryColor,
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
