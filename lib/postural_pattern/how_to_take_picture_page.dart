import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screen/how_to_take_picture_screen.dart';

class HowToTakePicturePage extends StatelessWidget {
  const HowToTakePicturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
      ),
      body: const HowToTakePictureScreen(),
    );
  }
}
