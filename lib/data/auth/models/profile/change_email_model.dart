class ChangeEmailModel {
  String email;
  String password;

  ChangeEmailModel(this.email, this.password);

  void clear() {
    email = "";
    password = "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}
