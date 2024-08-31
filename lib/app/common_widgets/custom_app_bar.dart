import 'package:flutter/material.dart';

import 'custom_app_bar_shape.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.onActionTap,
    this.actions,
  });

  final String? title;

  final VoidCallback? onActionTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: title != null ? 110 : 150,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      actions: actions,
      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            )
          : SizedBox(
              height: 150,
              child: Center(
                child: Image.asset(
                  'assets/images/logos/logo-black-white.png',
                  height: 100,
                ),
              ),
            ),
      shape: const CustomAppBarShape(),
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(title != null ? 110 : 150);
}
