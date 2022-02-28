import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_location_model.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_nas_model.dart';
import 'package:moj_student/data/internet/admin/exceptions/iadmin_norole_exception.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_users_model.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';

class InternetAdminRepository {
  final client = InterceptedClient.build(
    interceptors: [],
    retryPolicy: TokenExpiredInterceptor(),
  );

  AuthRepository authRepository;

  InternetAdminRepository({required this.authRepository});

  static const _internetAdminNasUrl = "https://student.sd-lj.si/api/nas";
  static const _internetAdminUsersUrl =
      "https://student.sd-lj.si/api/user/list";
  static const _internetAdminLocationUrl =
      "https://student.sd-lj.si/api/location/list";

  Future<List<InternetAdminNasModel>> getNasStatus({String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response =
        await client.get(Uri.parse(_internetAdminNasUrl), headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      var model = List<InternetAdminNasModel>.from(
          l.map((model) => InternetAdminNasModel.fromJson(model)));
      return model;
    } else if (response.statusCode == 403) {
      throw InternetAdminNoRoleException("Uporabnik nima pravice za dostop");
    } else {
      throw Exception(response.body);
    }
  }

  Future<InternetAdminUsersPaginationModel> getUsers({
    int perPage = 20,
    int page = 1,
    int? location = 1,
    String? search,
    String? token,
  }) async {
    String url =
        _internetAdminUsersUrl + "?page=$page&pp=$perPage&location=$location";
    if (search != null) {
      url += "&search=$search";
    }

    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var uri = Uri.parse(url);

    // final response =
    //     await client.get(uri, headers: headers);

    var dio = Dio();
    dio.options.headers = headers;

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      var responseData = response.data;
      var data = InternetAdminUsersPaginationModel.fromJson(responseData);
      return data;
    } else if (response.statusCode == 403) {
      throw InternetAdminNoRoleException("Uporabnik nima pravice za dostop");
    } else {
      throw InternetAdminNoRoleException("Uporabnik nima pravice za dostop");
      // throw Exception(response.body);
    }
  }

  Future<List<InternetAdminLocationModel>> getLocations({String? token}) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final response = await client.get(Uri.parse(_internetAdminLocationUrl),
        headers: headers);

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      var model = List<InternetAdminLocationModel>.from(
          l.map((model) => InternetAdminLocationModel.fromJson(model)));
      return model;
    } else if (response.statusCode == 403) {
      throw InternetAdminNoRoleException("Uporabnik nima pravice za dostop");
    } else {
      throw Exception(response.body);
    }
  }
}
