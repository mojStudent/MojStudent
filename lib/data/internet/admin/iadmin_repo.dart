import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_errors_model.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_location_model.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_nas_model.dart';
import 'package:moj_student/data/internet/admin/exceptions/iadmin_norole_exception.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_users_model.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';

class InternetAdminRepository extends InternetRepository {
  InternetAdminRepository({required AuthRepository authRepository})
      : super(authRepository: authRepository);

  static const _internetAdminNasUrl = "https://student.sd-lj.si/api/nas";
  static const _internetAdminUsersUrl =
      "https://student.sd-lj.si/api/user/list";
  static const _internetAdminLocationUrl =
      "https://student.sd-lj.si/api/location/list";

  static const _internetAdminUserDetail = "https://student.sd-lj.si/api/user/";

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

  Future<InternetAdminUserModel> getUserDetails(int userId,
      {String? token}) async {
    String url = _internetAdminUserDetail + "$userId";

    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var dio = Dio();
    dio.options.headers = headers;

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      var responseData = response.data;
      var data = InternetAdminUserModel.fromJson(responseData);
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

  Future<InternetTrafficModel> getInternetTrafficForUser(int userId,
      {String? token}) async {
    return await super.getInternetTraffic(
        token: token,
        customUrl: "https://student.sd-lj.si/api/user/$userId/log/traffic");
  }

  Future<List<InternetConnectionLogModel>> getInternetConnectionsForUser(
      int userId,
      {String? token}) async {
    return await super.getInternetConnections(
        token: token,
        customUrl: "https://student.sd-lj.si/api/user/$userId/log/connection");
  }

  Future<IAdminErrorsPaginationModel> getErrors({
    int page = 1,
    int perPage = 20,
    String? username,
    String? description,
    String? token,
  }) async {
    if (token == null) {
      var auth = AuthRepository();
      token = auth.token!;
    }

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String url = "https://student.sd-lj.si/api/error?page=$page&pp=$perPage";
    if(username != null) {
      url += "&username=$username";
    }

    if(description != null) {
      url += "&description=$description";
    }

    final response = await client.get(Uri.parse(url),
        headers: headers);

    if (response.statusCode == 200) {
      var model =
          IAdminErrorsPaginationModel.fromJson(json.decode(response.body));
      return model;
    } else if (response.statusCode == 403) {
      throw InternetAdminNoRoleException("Uporabnik nima pravice za dostop");
    } else {
      throw Exception(response.body);
    }
  }
}
