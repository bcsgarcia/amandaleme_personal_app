import 'package:flutter/material.dart';

import '../../../app/theme/light_theme.dart';

class CicleImageWithIconCan extends StatelessWidget {
  const CicleImageWithIconCan({
    super.key,
    this.photoUrl,
  });

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    var photoImage = photoUrl != null ? Image.network(photoUrl!) : Image.asset('assets/images/icons/user.png');

    return Stack(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage: photoImage.image,
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
