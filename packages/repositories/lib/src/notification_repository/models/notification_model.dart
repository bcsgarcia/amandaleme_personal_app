class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.readDate,
    required this.appointmentEndDate,
    required this.appointmentStartDate,
  });

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime? readDate;
  final DateTime? appointmentStartDate;
  final DateTime? appointmentEndDate;

  factory NotificationModel.fromJson(Map json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['notificationDate']),
      appointmentStartDate: json['appointmentStartDate'] == null
          ? null
          : DateTime.parse(json['appointmentStartDate']),
      appointmentEndDate: json['appointmentEndDate'] == null
          ? null
          : DateTime.parse(json['appointmentEndDate']),
      readDate:
          json['readDate'] == null ? null : DateTime.parse(json['readDate']),
    );
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'notificationDate': date.toIso8601String(),
      'readDate': readDate?.toIso8601String(),
      'appointmentStartDate': appointmentStartDate?.toIso8601String(),
      'appointmentEndDate': appointmentEndDate?.toIso8601String(),
    };
  }
}
