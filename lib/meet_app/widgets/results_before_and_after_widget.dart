import 'package:flutter/material.dart';

import '../../app/theme/light_theme.dart';
import 'widgets.dart';

class ResultsBeforeAndAfterWidget extends StatefulWidget {
  const ResultsBeforeAndAfterWidget({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  State<ResultsBeforeAndAfterWidget> createState() => _ResultsBeforeAndAfterWidgetState();
}

class _ResultsBeforeAndAfterWidgetState extends State<ResultsBeforeAndAfterWidget> {
  List<String> get _images => widget.images;
  final PageController _pageController = PageController();

  int index = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page!.round() != index) {
        setState(() {
          index = _pageController.page!.round();
        });
      }
    });
  }

  void nextImage() {
    index++;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    setState(() {});
  }

  void previusImage() {
    index--;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: index == 0 ? null : previusImage,
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: primaryColor,
                ),
              ),
              SizedBox(
                width: 255,
                height: 206,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: index == index ? 1.0 : 0.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          widget.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: index + 1 == _images.length ? null : nextImage,
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ImageDotsIndicatorWidget(activeIndex: index, numberOfImages: _images.length)
      ],
    );
  }
}
