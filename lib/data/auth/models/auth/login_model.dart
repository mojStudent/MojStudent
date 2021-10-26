class LoginModel {
  late String username;
  late String password;

  LoginModel({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['password'] = password;
    return _data;
  }

  LoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }
}
