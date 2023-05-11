import 'package:amandaleme_personal_app/app/common_widgets/common_widgets.dart';
import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:home_repository/home_repository.dart';

import '../../../app/common_widgets/random_image.dart';

class MyTrainingPlanWidget extends StatefulWidget {
  MyTrainingPlanWidget({super.key, required this.workoutSheets});

  List<WorkoutSheetModel> workoutSheets;

  @override
  State<MyTrainingPlanWidget> createState() => _MyTrainingPlanWidgetState();
}

class _MyTrainingPlanWidgetState extends State<MyTrainingPlanWidget> {
  List<WorkoutSheetModel> get _workoutSheets => widget.workoutSheets;

  final List<String> _backgroundImages = [];

  late PageController _pageController;
  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    _workoutSheets.sort((a, b) {
      if (a.date == null && b.date == null) {
        return 0;
      }
      if (a.date == null) {
        return -1;
      }
      if (b.date == null) {
        return 1;
      }
      return b.date!.compareTo(a.date!);
    });
    buildArrayBackgroundImages();
    _pageController = PageController(viewportFraction: 0.7)
      ..addListener(() {
        setState(() {
          currentPage = _pageController.page!;
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  buildArrayBackgroundImages() {
    for (int i = 0; i <= _workoutSheets.length; i++) {
      _backgroundImages.add(getRandomImagePath());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 270,
      child: PageView.builder(
        controller: _pageController,
        reverse: true,
        itemCount: _workoutSheets.length,
        itemBuilder: (context, index) {
          double scaleFactor =
              1 - (index - currentPage).abs().clamp(0, 1).toDouble();
          double scale = 0.8 + scaleFactor * 0.2;
          return Transform.scale(
            scale: scale,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                boxShadow: [
                  defaultBoxShadow(),
                ],
                borderRadius: BorderRadius.circular(15),
                color: Colors.black12,
                image: DecorationImage(
                  image: AssetImage(
                    _backgroundImages[index],
                  ),
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.srcOver,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, top: 7),
                        child: Text(
                          DateFormat('E, d MMMM').format(
                            _workoutSheets[index].date ?? DateTime.now(),
                          ),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _workoutSheets[index].date != null
                        ? const IconWorkoutSheetFinished()
                        : NameWorkoutSheet(
                            text: _workoutSheets[index].name,
                            paddingTop: 40,
                          ),
                  ),
                  if (_workoutSheets[index].date != null)
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: NameWorkoutSheet(
                          text: _workoutSheets[index].name,
                          paddingBottom: 10,
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NameWorkoutSheet extends StatelessWidget {
  const NameWorkoutSheet({
    super.key,
    required this.text,
    this.paddingTop,
    this.paddingBottom,
  });

  final String text;
  final double? paddingTop;
  final double? paddingBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: paddingTop ?? 0.0,
          bottom: paddingBottom ?? 0.0,
          left: 8,
          right: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class IconWorkoutSheetFinished extends StatelessWidget {
  const IconWorkoutSheetFinished({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: Colors.white,
      radius: 35,
      child: Icon(
        Icons.check,
        color: primaryColor,
        size: 30,
      ),
    );
  }
}
