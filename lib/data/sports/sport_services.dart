import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/sports/models/sport_subcribtion_model.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';

class SportsRepository {
  final client = InterceptedClient.build(
    interceptors: [],
    retryPolicy: TokenExpiredInterceptor(),
  );

  AuthRepository authRepository;

  SportsRepository({required this.authRepository});

  static const _sportSubscriptions =
      "https://student.sd-lj.si/api/sport/subscription";

  Future<List<SportSubscriptionModel>> getSubscriptions(
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
        await client.get(Uri.parse(_sportSubscriptions), headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      var model = List<SportSubscriptionModel>.from(
        l.map((model) => SportSubscriptionModel.fromJson(model)),
      );
      return model;
    } else {
      throw Exception(response.body);
    }
  }
}
