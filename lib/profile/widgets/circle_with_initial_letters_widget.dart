import 'package:flutter/material.dart';

class CircleWithInitialLettersWidget extends StatelessWidget {
  final String initialLetters;
  final double size;
  const CircleWithInitialLettersWidget({
    Key? key,
    required this.initialLetters,
    this.size = 65,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xffD7D7D7).withOpacity(0.15),
              const Color(0xffB1B1B1),
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(65))),
      child: Center(
        child: Text(
          initialLetters,
          style: textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xffFFFFFF),
          ),
        ),
      ),
    );
  }
}
