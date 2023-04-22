import 'package:flutter/material.dart';

import '../../../app/theme/light_theme.dart';
import 'widgets.dart';

class MyClassVideo extends StatelessWidget {
  const MyClassVideo({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Text(
            'O que acontecerá nas minhas aulas?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 23,
                  color: blackColor,
                ),
          ),
        ),
        const SizedBox(height: 12),
        CompanyVideo(videoUrl: videoUrl),
      ],
    );
  }
}
