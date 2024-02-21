import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notification_repository/notification_repository.dart';

import '../../lib.dart';

class NotificationsItemWidget extends StatelessWidget {
  const NotificationsItemWidget({
    super.key,
    required this.notification,
  });

  final NotificationModel notification;

  String formatDateTime(DateTime date) {
    var now = DateTime.now();
    var difference = now.difference(date);

    if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d';
    } else {}
    return DateFormat('dd/MM/yy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          defaultBoxShadow(),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  notification.title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Text(
                formatDateTime(notification.date),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            notification.description,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  height: 1.4,
                ),
          ),
          if (notification.appointmentStartDate != null && notification.appointmentEndDate != null)
            Row(
              children: [
                Expanded(
                  child: BadgeDateWidget(
                    notificationRead: notification.appointmentStartDate!,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: BadgeTimeWidget(
                    notificationStartRead: notification.appointmentStartDate!,
                    notificationEndRead: notification.appointmentEndDate!,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class BadgeDateWidget extends StatelessWidget {
  const BadgeDateWidget({
    super.key,
    required this.notificationRead,
  });

  final DateTime notificationRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 34,
      decoration: BoxDecoration(
        color: notificationRead.difference(DateTime.now()).inDays < 0 ? Colors.grey : secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 13),
          const Icon(
            Icons.calendar_today_outlined,
            color: Colors.white,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              DateFormat('E, d/MM').format(notificationRead),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
            ),
          )
        ],
      ),
    );
  }
}

class BadgeTimeWidget extends StatelessWidget {
  const BadgeTimeWidget({
    super.key,
    required this.notificationStartRead,
    required this.notificationEndRead,
  });

  final DateTime notificationStartRead;
  final DateTime notificationEndRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 34,
      decoration: BoxDecoration(
        color: notificationStartRead.difference(DateTime.now()).inDays < 0 ? Colors.grey : secondaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(
            Icons.access_time,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    '${DateFormat('HH:mm').format(notificationStartRead)} - ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                  ),
                ),
                Flexible(
                  child: Text(
                    DateFormat('HH:mm').format(notificationEndRead),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
