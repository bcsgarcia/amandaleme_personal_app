import 'package:amandaleme_personal_app/app/theme/light_theme.dart';
import 'package:flutter/material.dart';

import '../../../app/common_widgets/common_widgets.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      decoration: BoxDecoration(
        color: blackColor,
        boxShadow: [
          defaultBoxShadow(),
        ],
        image: const DecorationImage(
          scale: 2.5,
          image: AssetImage(
            'assets/images/logos/logo-black-white.png',
          ),
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
    );
  }
}
