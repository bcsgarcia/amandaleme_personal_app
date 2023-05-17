import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
      ),
    );
  }
}
