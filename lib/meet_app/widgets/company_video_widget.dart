import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../lib.dart';

class CompanyVideoWidget extends StatefulWidget {
  const CompanyVideoWidget({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<CompanyVideoWidget> createState() => CompanyVideoWidgetState();
}

class CompanyVideoWidgetState extends State<CompanyVideoWidget> {
  VideoPlayerController? _controller;

  String get _videoUrl => widget.videoUrl;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (_videoUrl.isEmpty) {
      setState(() => isLoading = false);
      return;
    }

    _controller = VideoPlayerController.networkUrl(Uri.parse(_videoUrl))
      ..initialize().then((_) {
        setState(() => isLoading = false);
      });
  }

  void startCompanyVideo() {
    _controller?.play();

    setState(() {});
  }

  @override
  void dispose() {
    if (_controller?.value.isPlaying ?? false) _controller?.pause();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 200,
      width: screenSize.width < 600 ? double.infinity : 500,
      child: Stack(
        children: [
          Positioned(
            child: GestureDetector(
              onTap: () {
                if (_controller?.value.isPlaying ?? false) {
                  _controller?.pause();
                } else {
                  _controller?.play();
                }

                setState(() {});
              },
              child: _controller == null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox.expand(
                          child: Image.asset(
                            getRandomImagePath(),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        ClipRRect(
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
                                  width: _controller!.value.size.width,
                                  height: _controller!.value.size.height,
                                  child: VideoPlayer(
                                    _controller!,
                                  )),
                            ),
                          ),
                        ),
                        if (_controller != null) VideoProgressBarIndicatorWidget(controller: _controller!),
                      ],
                    ),
            ),
          ),
          if (_controller == null)
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.none,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('assets/images/icons/no-video.png'),
                    ),
                  ),
                ),
              ),
            )
          else if (!(_controller?.value.isPlaying ?? false))
            Center(
              child: CircleAvatar(
                backgroundColor: whiteColor,
                radius: 20, // Control the radius of the CircleAvatar widget
                child: isLoading
                    ? const CircularProgressIndicator(
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
