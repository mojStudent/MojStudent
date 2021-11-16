import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/help/internet_help_detail_model.dart';
import 'package:moj_student/data/internet/models/help/internet_help_master_model.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';
import 'package:moj_student/services/internet/internet_help/internet_help_bloc.dart';
import 'package:http/http.dart';

class InternetHelpRepo extends InternetRepository {
  InternetHelpRepo({required AuthRepository authRepository})
      : super(authRepository: authRepository);

  static const _urlMasterHelp = "https://student.sd-lj.si/api/help/internet";
  static const _urlDetailHelp = "https://student.sd-lj.si/api/help/slides/";

  Future<InternetHelpMasterModel> loadMasterData({String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await client.get(Uri.parse(_urlMasterHelp), headers: headers);

    if (response.statusCode == 200) {
      var model = InternetHelpMasterModel.fromJson(jsonDecode(response.body));
      return model;
    } else {
      throw Exception(response.body);
    }
  }

  Future<List<InternetHelpDetailModel>> loadSteps(String url,
      {String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var uri = Uri.parse("$_urlDetailHelp$url");
    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      var model = List<InternetHelpDetailModel>.from(
          l.map((model) => InternetHelpDetailModel.fromJson(model)));
      return model;
    } else {
      throw Exception(response.body);
    }
  }
}
