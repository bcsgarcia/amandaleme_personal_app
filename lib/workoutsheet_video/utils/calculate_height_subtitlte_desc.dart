import 'package:flutter/material.dart';

double calculateSubtitleAndDescHeight(String title, String description, BuildContext context) {
  final TextPainter titlePainter = TextPainter(
    text: TextSpan(
      text: title,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18, fontWeight: FontWeight.bold, height: 1.5),
    ),
    textDirection: TextDirection.ltr,
    maxLines: null,
  );

  final TextPainter descriptionPainter = TextPainter(
    text: TextSpan(
      text: description,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16, height: 1.5),
    ),
    textDirection: TextDirection.ltr,
    maxLines: null,
  );

  titlePainter.layout(maxWidth: MediaQuery.of(context).size.width - 250);
  descriptionPainter.layout(maxWidth: MediaQuery.of(context).size.width - 260);

  final height = titlePainter.size.height + descriptionPainter.size.height < 150 ? 250 : titlePainter.size.height + descriptionPainter.size.height;

  return height + 15;
}
