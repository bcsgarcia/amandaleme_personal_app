import 'package:flutter/material.dart';

import '../../lib.dart';

class AppHeaderWithTitleLeadinAndAction extends StatelessWidget {
  const AppHeaderWithTitleLeadinAndAction({
    super.key,
    required this.title,
    this.leadingButton,
    this.actionButton,
  });

  final String title;
  final IconButton? leadingButton;
  final IconButton? actionButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: blackColor,
        boxShadow: [
          defaultBoxShadow(),
        ],
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 12),
                  child: leadingButton ?? Container(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 12),
                  child: actionButton ?? Container(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
