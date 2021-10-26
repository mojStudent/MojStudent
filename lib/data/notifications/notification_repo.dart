import 'dart:convert';

import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/notifications/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationRepo {
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

    final response = await http.get(Uri.parse(_inboxUrl), headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      var model = List<NotificationModel>.from(
          l.map((model) => NotificationModel.fromJson(model)));
      return model;
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await getNotifications(token: token);
      } else {
        throw Exception("Napaka pri ponovni prijavi");
      }
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

    final response = await http.get(
        Uri.parse(_envelopeUrl + notificationId.toString()),
        headers: headers);

    if (response.statusCode == 200) {
      var model = NotificationModel.fromJson(jsonDecode(response.body));
      return model;
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await getNotification(
            token: token, notificationId: notificationId);
      } else {
        throw Exception("Napaka pri ponovni prijavi");
      }
    } else {
      throw Exception(response.body);
    }
  }

  Future<bool> reLoginUser() async {
    var authRepo = AuthRepository();
    try {
      await authRepo.login(null);
      return true;
    } catch (e) {
      return false;
    }
  }
}
