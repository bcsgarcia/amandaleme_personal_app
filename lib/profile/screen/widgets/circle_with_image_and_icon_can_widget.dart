import 'package:flutter/material.dart';

import '../../../app/theme/light_theme.dart';

class CicleImageWithIconCan extends StatelessWidget {
  const CicleImageWithIconCan({
    super.key,
    required String photoUrl,
  }) : _photoUrl = photoUrl;

  final String _photoUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: NetworkImage(_photoUrl),
          backgroundColor: Colors.white,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: secondaryColor, width: 2),
            ),
            child: const Center(
              child: Icon(
                Icons.camera_alt_outlined,
                color: secondaryColor,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
