import 'package:flutter/material.dart';

import '../../lib.dart';

class HowToTakeAPictureWidget extends StatelessWidget {
  const HowToTakeAPictureWidget({super.key});

  _goToHowToTakePicturePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HowToTakePicturePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToHowToTakePicturePage(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 51,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: primaryColor,
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                'Saiba como tirar suas fotos',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
