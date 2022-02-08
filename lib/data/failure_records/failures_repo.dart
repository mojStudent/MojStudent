import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/exceptions/empty_data_exception.dart';
import 'package:moj_student/data/failure_records/failure_record_model.dart';
import 'package:moj_student/data/failure_records/new_failure_model.dart';
import 'package:moj_student/data/failure_records/new_failure_options_model.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';

class FailureRecordRepo {
  final client = InterceptedClient.build(
    interceptors: [],
    retryPolicy: TokenExpiredInterceptor(),
  );

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

    final response = await client.get(Uri.parse(_damageRecordUrl + "$page"),
        headers: headers);

    if (response.statusCode == 200) {
      try {
        var model = FailurePaginationModel.fromJson(jsonDecode(response.body));
        return model;
      } on EmptyDataException {
        rethrow;
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

    final response = await client.get(Uri.parse(_optionsUrl), headers: headers);

    if (response.statusCode == 200) {
      var model = FailureOptions.fromJson(jsonDecode(response.body));
      return model;
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

    final response = await client.post(Uri.parse(_newFailurePostUrl),
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
