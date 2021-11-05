import 'dart:convert';

import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/failure_records/failure_record_model.dart';
import 'package:http/http.dart' as http;
import 'package:moj_student/data/failure_records/new_failure_model.dart';
import 'package:moj_student/data/failure_records/new_failure_options_model.dart';

class FailureRecordRepo {
  static const _damageRecordUrl = "https://student.sd-lj.si/api/damage?page=";
  static const _optionsUrl = "https://student.sd-lj.si/api/damage/options";
  static const _newFailurePostUrl = "https://student.sd-lj.si/api/damage";

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

  Future<FailureOptions> getFailureOptions(
      {String? token, int page = 1}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await http.get(Uri.parse(_optionsUrl), headers: headers);

    if (response.statusCode == 200) {
      var model = FailureOptions.fromJson(jsonDecode(response.body));
      return model;
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await getFailureOptions(token: token);
      } else {
        throw Exception("Napaka pri ponovni prijavi");
      }
    } else {
      throw Exception(response.body);
    }
  }

  Future<bool> postNewFailure(NewFailureModel model, {String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    var body = jsonEncode(model.toJson());
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Length': utf8.encode(body).length.toString()
    };

    final response = await http.post(Uri.parse(_newFailurePostUrl),
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await postNewFailure(model, token: token);
      } else {
        throw Exception("Napaka pri ponovni prijavi");
      }
    } else {
      return false;
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
