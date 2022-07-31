import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/auth/models/auth/loggedin_model.dart';
import 'package:moj_student/data/auth/models/auth/login_model.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/excpetion/errror_model.dart';
import 'package:moj_student/data/excpetion/sd_api_exception.dart';
import 'package:moj_student/services/interceptors/token_expired_inetrecptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _loginUrl = "https://student.sd-lj.si/api/user/login";
  final client = InterceptedClient.build(
    interceptors: [],
    retryPolicy: TokenExpiredInterceptor(),
  );

  static UserModel? _loggedInUser;
  static String? _token;

  static LoginModel? loginModel;

  static isNetAdmin() => _loggedInUser?.roles.any((role) =>
      role.role == "ROLE_INTADMIN" || role.role == "ROLE_INTADMINASSIS");

  Future<UserModel> login(LoginModel? login) async {
    if (login != null) {
      AuthRepository.loginModel = login;
    } else if (loginModel != null) {
      login = loginModel;
    } else {
      throw Exception("Napaka programa");
    }

    login = login!;

    var body = jsonEncode(login.toJson());
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Content-Length': utf8.encode(body).length.toString()
    };

    final response =
        await client.post(Uri.parse(_loginUrl), body: body, headers: headers);

    if (response.statusCode == 200) {
      var model = LoggedInModel.fromJson(jsonDecode(response.body));
      _loggedInUser = model.user;
      _token = model.token;

      LoginModelSharedPreferences.saveUserToSharedPreferences(loginModel);

      return model.user;
    } else {
      throw SdApiException(ApiErrorModel.fromJson(json.decode(response.body)));
    }
  }

  Future<void> logOut() async {
    _token = null;
    _loggedInUser = null;
    loginModel = null;

    await LoginModelSharedPreferences.deleteUserFromSharedPreferences();
  }

  UserModel? get loggedInUser => _loggedInUser;

  String? get token => _token;
}

class LoginModelSharedPreferences {
  static Future<void> saveUserToSharedPreferences(
      LoginModel? loginModel) async {
    if (loginModel == null) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginModelString = jsonEncode(loginModel.toJson());
    prefs.setString("loginModel", loginModelString);
  }

  static Future<LoginModel?> getUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? loginModelString = prefs.getString('loginModel');

    if (loginModelString == null) {
      return null;
    }

    Map<String, dynamic> json = jsonDecode(loginModelString);
    return LoginModel.fromJson(json);
  }

  static Future<void> deleteUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("loginModel");
  }
}
