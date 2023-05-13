import 'package:amandaleme_personal_app/notifications/cubit/notification_cubit.dart';
import 'package:amandaleme_personal_app/notifications/screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/notification_repository.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    super.key,
    required this.notifications,
  });

  final List<NotificationModel> notifications;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> get _notifications => widget.notifications;

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().updateUnreadNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationScreen(notifications: _notifications),
    );
  }
}
