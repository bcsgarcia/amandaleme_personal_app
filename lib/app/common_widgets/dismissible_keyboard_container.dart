import 'package:flutter/material.dart';

class DismissibleKeyboardContainer extends StatelessWidget {
  final Widget child;

  const DismissibleKeyboardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
