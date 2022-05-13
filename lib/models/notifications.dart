class Notifications {
  Notifications({this.notifications = const []});

  final List<Notification> notifications;

  factory Notifications.fromJson(List<Map<String, dynamic>> json) {
    return Notifications(
        notifications: json.map((e) => Notification.fromJson(e)).toList());
  }
}

class Notification {
  Notification({this.id, this.userId, this.message, this.dateTime});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        id: json['id'],
        userId: json['user_id'],
        message: json['notification_msg'],
        dateTime: json['date_created']);
  }

  final String? id;
  final String? userId;
  final String? message;
  final String? dateTime;
}
