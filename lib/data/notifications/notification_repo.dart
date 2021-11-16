import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/notifications/notification_model.dart';
import 'package:http/http.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';

class NotificationRepo {
  final client = InterceptedClient.build(
    interceptors: [],
    retryPolicy: TokenExpiredInterceptor(),
  );
  static const _inboxUrl = "https://student.sd-lj.si/api/notification/inbox";
  static const _envelopeUrl =
      "https://student.sd-lj.si/api/notification/envelope/";

  Future<List<NotificationModel>> getNotifications({String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await client.get(Uri.parse(_inboxUrl), headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      var model = List<NotificationModel>.from(
          l.map((model) => NotificationModel.fromJson(model)));
      return model;
    } else {
      throw Exception(response.body);
    }
  }

  Future<NotificationModel> getNotification(
      {String? token, required int notificationId}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await client.get(
        Uri.parse(_envelopeUrl + notificationId.toString()),
        headers: headers);

    if (response.statusCode == 200) {
      var model = NotificationModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception(response.body);
    }
  }
}
