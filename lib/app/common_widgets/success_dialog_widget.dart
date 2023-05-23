// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessDialogWidget extends StatefulWidget {
  const SuccessDialogWidget({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  _SuccessDialogWidgetState createState() => _SuccessDialogWidgetState();
}

class _SuccessDialogWidgetState extends State<SuccessDialogWidget> {
  String get _title => widget.title;
  String get _description => widget.description;

  String get _buttonLabel => widget.buttonLabel;
  VoidCallback get _onPressed => widget.onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      children: [
        Lottie.network(
          'https://assets3.lottiefiles.com/packages/lf20_pktj8ecn.json',
          height: 100,
        ),
        Text(
          _title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 9),
          child: Text(
            _description,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 16,
                  height: 1.5,
                ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 43,
          margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          child: ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _onPressed,
            child: Text(
              _buttonLabel,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
      // content: Text(widget.description),

      // actions: [
      //   if (widget.button1Label != null && widget.button1OnPressed != null)
      //     TextButton(
      //       onPressed: widget.button1OnPressed!,
      //       child: Text(widget.button1Label!),
      //     ),
      //   if (widget.button2Label != null && widget.button2OnPressed != null)
      //     TextButton(
      //       onPressed: widget.button2OnPressed!,
      //       child: Text(widget.button2Label!),
      //     ),
      // ],
    );
  }
}
