import 'dart:convert';

import 'package:http/http.dart';

import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_model.dart';

class DamageRecordRepo {
  final client = Client();

  static const _damageRecordUrl =
      "https://student.sd-lj.si/api/damage-record?page=";

  Future<SkodniZapisnikPaginationModel> getDamageRecords(
      {String? token, int page = 1}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await client.get(Uri.parse(_damageRecordUrl + "$page"), headers: headers);

    if (response.statusCode == 200) {
      var model =
          SkodniZapisnikPaginationModel.fromJson(jsonDecode(response.body));
      return model;
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await getDamageRecords(token: token);
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
