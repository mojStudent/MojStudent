import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_model.dart';
import 'package:moj_student/data/exceptions/empty_data_exception.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';

class DamageRecordRepo {
  final client = InterceptedClient.build(
    interceptors: [],
    retryPolicy: TokenExpiredInterceptor(),
  );

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

    final response = await client.get(Uri.parse(_damageRecordUrl + "$page"),
        headers: headers);

    if (response.statusCode == 200) {
      try {
        var model =
            SkodniZapisnikPaginationModel.fromJson(jsonDecode(response.body));
        return model;
      } on EmptyDataException {
        rethrow;
      }
    } else {
      throw Exception(response.body);
    }
  }
}
