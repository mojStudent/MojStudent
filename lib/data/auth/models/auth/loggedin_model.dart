import 'package:moj_student/data/auth/models/auth/user_model.dart';

class LoggedInModel {
  LoggedInModel({
    required this.token,
    required this.user,
  });
  late final String token;
  late final UserModel user;

  LoggedInModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = UserModel.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['user'] = user.toJson();
    return _data;
  }
}
