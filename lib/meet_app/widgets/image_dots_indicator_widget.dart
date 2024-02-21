import 'package:flutter/material.dart';

import '../../lib.dart';

class ImageDotsIndicatorWidget extends StatelessWidget {
  const ImageDotsIndicatorWidget({
    super.key,
    required this.activeIndex,
    required this.numberOfImages,
  });

  final int activeIndex;
  final int numberOfImages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfImages,
        (index) => Container(
          width: activeIndex == index ? 10 : 6,
          height: activeIndex == index ? 10 : 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
