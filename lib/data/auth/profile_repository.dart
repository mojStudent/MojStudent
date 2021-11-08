import 'dart:convert';

import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/login_model.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/auth/models/profile/change_email_model.dart';

import 'package:http/http.dart' as http;
import 'package:moj_student/data/auth/models/profile/change_password_model.dart';

class ProfileRepository extends AuthRepository {
  static const _changeEmailUrl =
      "https://student.sd-lj.si/api/user/email/change";

  static const _changePasswordUrl =
      "https://student.sd-lj.si/api/user/password/change";

  Future<void> mailChange(ChangeEmailModel model) async {
    final token = super.token;
    if (token == null) {
      throw Exception("Napaka programa");
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(Uri.parse(_changeEmailUrl),
        body: jsonEncode(model.toJson()), headers: headers);

    if (response.statusCode == 200) {
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await mailChange(model);
      } else {
        throw Exception("Napaka pri ponovni prijavi");
      }
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> passwordChange(ChangePasswordModel model) async {
    final token = super.token;
    if (token == null) {
      throw Exception("Napaka programa");
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.post(Uri.parse(_changePasswordUrl),
        body: jsonEncode(model.toJson()), headers: headers);

    if (response.statusCode == 200) {
      await reLoginUser(
        model: LoginModel(
          username: super.loggedInUser!.username!,
          password: model.newPass,
        ),
      );
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await passwordChange(model);
      } else {
        throw Exception("Napaka pri ponovni prijavi");
      }
    } else {
      throw Exception(response.body);
    }
  }

  Future<bool> reLoginUser({LoginModel? model}) async {
    try {
      await super.login(model);
      return true;
    } catch (e) {
      return false;
    }
  }
}
