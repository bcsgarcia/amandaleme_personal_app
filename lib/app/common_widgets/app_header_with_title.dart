import 'package:flutter/material.dart';

import '../theme/light_theme.dart';
import 'box_shadow_default.dart';

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
      height: 150,
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
                  padding: const EdgeInsets.only(top: 60, left: 12),
                  child: leadingButton ?? Container(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  title,
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
