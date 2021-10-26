import 'package:moj_student/data/notifications/attachment_model.dart';

class NotificationModel {
  late int id;
  late String subject;
  late String date;
  String? created;
  String? author;
  String? body;
  late bool read;
  List<AttachmentModel> attachments = [];

  NotificationModel({
    required this.id,
    required this.subject,
    this.date = '',
    this.read = true,
    this.created,
    this.author,
    this.body,
    this.attachments = const [],
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    subject = json['subject'] ?? '';
    date = json['date'] ?? '';
    read = json['read'] ?? false;
    created = json['created'] ?? '';
    author = json['author'] ?? '';
    body = json['body'] ?? '';
    if (json['attachments'] != null) {
      attachments = List.from(json['attachments'])
          .map((e) => AttachmentModel.fromJson(e))
          .toList();
    }
  }
}
