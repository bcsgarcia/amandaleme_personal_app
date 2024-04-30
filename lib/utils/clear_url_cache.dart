import 'package:flutter/painting.dart';

void clearImageCache() async {
  PaintingBinding.instance.imageCache.clear();
  PaintingBinding.instance.imageCache.clearLiveImages();
  // return Future.delayed(const Duration(seconds: 1), () {});
}
