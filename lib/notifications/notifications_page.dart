import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/notification_repository.dart';

import '../lib.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
    required this.notifications,
  });

  final List<NotificationModel> notifications;

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationModel> get _notifications => widget.notifications;

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().updateUnreadNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: true,
        backgroundColor: blackColor,
        elevation: 0,
      ),
      body: NotificationsScreen(notifications: _notifications),
    );
  }
}
