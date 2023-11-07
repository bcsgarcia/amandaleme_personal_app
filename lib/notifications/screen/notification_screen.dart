import 'package:amandaleme_personal_app/notifications/screen/widgets/notification_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:notification_repository/notification_repository.dart';

import '../../app/common_widgets/common_widgets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
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

            return NotificationItem(notification: item);
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
