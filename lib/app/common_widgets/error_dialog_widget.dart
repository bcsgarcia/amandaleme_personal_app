// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ErrorDialog extends StatefulWidget {
  final String title;
  final String description;
  final String? button1Label;
  final VoidCallback? button1OnPressed;
  final String? button2Label;
  final VoidCallback? button2OnPressed;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.description,
    this.button1Label,
    this.button1OnPressed,
    this.button2Label,
    this.button2OnPressed,
  });

  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.description),
      actions: [
        if (widget.button1Label != null && widget.button1OnPressed != null)
          TextButton(
            onPressed: widget.button1OnPressed!,
            child: Text(widget.button1Label!),
          ),
        if (widget.button2Label != null && widget.button2OnPressed != null)
          TextButton(
            onPressed: widget.button2OnPressed!,
            child: Text(widget.button2Label!),
          ),
      ],
    );
  }
}
