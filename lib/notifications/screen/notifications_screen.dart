import 'package:flutter/material.dart';
import 'package:notification_repository/notification_repository.dart';

import '../../lib.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    super.key,
    required this.notifications,
  });

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 130),
          itemCount: notifications.length,
          itemBuilder: (context, i) {
            final item = notifications[i];

            return NotificationsItemWidget(notification: item);
          },
        ),
        AppHeaderWithTitleLeadinAndAction(
          title: 'Notificações',
          leadingButton: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }
}
