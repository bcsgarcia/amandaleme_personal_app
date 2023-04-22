import 'package:flutter/material.dart';

class CallToActionButton extends StatelessWidget {
  const CallToActionButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        height: 51,
        width: 291,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
