import 'dart:convert';

import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:http/http.dart';

class InternetRepository {
  final client = Client();

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
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await getInternetTraffic(token: token);
      } else {
        throw Exception("Napaka pri ponovni prijavi");
      }
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
    } else if (response.statusCode == 403) {
      if (await reLoginUser()) {
        return await getInternetConnections(token: token);
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
