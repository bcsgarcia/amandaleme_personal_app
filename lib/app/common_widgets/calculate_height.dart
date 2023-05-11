import 'dart:ui' as ui;

import 'package:flutter/material.dart';

double calculateHeight(
  String description,
  TextStyle style,
  double width,
) {
  final textSpan = TextSpan(text: description, style: style);
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: ui.TextDirection.ltr,
    maxLines: null,
  );
  textPainter.layout(minWidth: 0, maxWidth: width);

  return textPainter.height + 30;
}
