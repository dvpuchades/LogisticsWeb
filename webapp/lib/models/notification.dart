class Notification {
  late String type;
  late String message;
  late String from;

  Notification(this.type, this.message, this.from);

  Notification.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'],
        from = json['from'];
}
