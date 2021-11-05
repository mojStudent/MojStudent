import 'dart:convert';

import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/failure_records/failure_record_model.dart';
import 'package:http/http.dart' as http;

class FailureRecordRepo {
  static const _damageRecordUrl =
      "https://student.sd-lj.si/api/damage?page=";

  Future<FailurePaginationModel> getFailureRecords(
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
        await http.get(Uri.parse(_damageRecordUrl + "$page"), headers: headers);

    if (response.statusCode == 200) {
      var model = FailurePaginationModel.fromJson(jsonDecode(response.body));
      return model;
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await getFailureRecords(token: token);
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
