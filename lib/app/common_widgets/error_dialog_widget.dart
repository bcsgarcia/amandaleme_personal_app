// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({
    super.key,
    this.title,
    this.description,
    this.buttonLabel,
    this.buttonPressed,
  });

  final String? title;
  final String? description;
  final String? buttonLabel;
  final VoidCallback? buttonPressed;

  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  String? get _title => widget.title;
  String? get _description => widget.description;

  String? get _buttonLabel => widget.buttonLabel;
  VoidCallback? get _onPressed => widget.buttonPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      children: [
        Lottie.network(
          'https://assets4.lottiefiles.com/packages/lf20_e1pmabgl.json',
          height: 80,
        ),
        Text(
          _title ?? 'Ops!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 9),
          child: Text(
            _description ?? 'Parece que algo deu errado. Por favor, tente novamente.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 16,
                  height: 1.5,
                ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 43,
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: ElevatedButton(
            key: const Key('loginForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _onPressed ?? () => Navigator.pop(context),
            child: Text(
              _buttonLabel ?? "Tentar novamente",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
