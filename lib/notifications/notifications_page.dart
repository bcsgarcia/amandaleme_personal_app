import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

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
      body: NotificationsScreen(notifications: _notifications),
    );
  }
}
