import 'package:flutter/material.dart';

import '../../../app/theme/light_theme.dart';
import 'widgets.dart';

class ResultsBeforeAndAfter extends StatefulWidget {
  const ResultsBeforeAndAfter({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<ResultsBeforeAndAfter> createState() => _ResultsBeforeAndAfterState();
}

class _ResultsBeforeAndAfterState extends State<ResultsBeforeAndAfter> {
  List<String> get _images => widget.images;

  int index = 0;

  void nextImage() {
    index++;
    setState(() {});
  }

  void previusImage() {
    index--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Text(
            'O que entrego?\nResultados!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 23,
                  color: blackColor,
                ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: index == 0 ? null : previusImage,
                icon: const Icon(Icons.arrow_back_ios_new),
                color: primaryColor,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 300,
                  child: Image.network(
                    widget.images[index],
                  ),
                ),
              ),
              IconButton(
                onPressed: index + 1 == _images.length ? null : nextImage,
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                color: primaryColor,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ImageDotsIndicator(activeIndex: index, numberOfImages: _images.length)
      ],
    );
  }
}
