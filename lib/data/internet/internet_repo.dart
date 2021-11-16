import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:http/http.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';

class InternetRepository {
  final client = InterceptedClient.build(
    interceptors: [],
    retryPolicy: TokenExpiredInterceptor(),
  );

  AuthRepository authRepository;

  InternetRepository({required this.authRepository});

  static const _internetTrafficUrl =
      "https://student.sd-lj.si/api/user/log/traffic";

  static const _internetConnectionsUrl =
      "https://student.sd-lj.si/api/user/log/connection";

  Future<InternetTrafficModel> getInternetTraffic({String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await client.get(Uri.parse(_internetTrafficUrl), headers: headers);

    if (response.statusCode == 200) {
      var model = InternetTrafficModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<InternetConnectionLogModel>> getInternetConnections(
      {String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await client.get(Uri.parse(_internetConnectionsUrl), headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      var model = List<InternetConnectionLogModel>.from(
          l.map((model) => InternetConnectionLogModel.fromJson(model)));
      return model;
    } else {
      throw Exception(response.body);
    }
  }
}
