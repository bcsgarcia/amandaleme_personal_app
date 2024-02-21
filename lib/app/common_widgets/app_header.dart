import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

import '../../lib.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({
    super.key,
    required this.notifications,
  });

  final List<NotificationModel> notifications;

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  List<NotificationModel> get _notifications => widget.notifications;

  bool hasNotificationUnread = false;

  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = context.read<HomeCubit>();
    hasNotificationUnread = verifyNotificationUnread();
  }

  bool verifyNotificationUnread() {
    return _notifications.any((notification) => notification.readDate == null);
  }

  void _goToNotificationPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => NotificationCubit(context.read<NotificationRepository>()),
          child: NotificationsPage(
            notifications: _notifications,
          ),
        ),
      ),
    );

    _homeCubit.getHomePage();
  }

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
                  padding: const EdgeInsets.only(top: 50, left: 12),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/images/logos/logo-black-white.png',
                height: 80,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 12),
                  child: IconButton(
                    onPressed: () => _goToNotificationPage(context),
                    icon: Stack(
                      children: [
                        const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 24,
                        ),
                        if (hasNotificationUnread)
                          Positioned(
                            right: 0,
                            child: Container(
                              height: 13,
                              width: 13,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(13),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
