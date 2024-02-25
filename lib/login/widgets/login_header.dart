import 'package:flutter/material.dart';

import '../../lib.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      // padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: blackColor,
        boxShadow: [
          defaultBoxShadow(),
        ],
        image: const DecorationImage(
          scale: 3.0,
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
