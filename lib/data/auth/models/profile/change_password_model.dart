class ChangePasswordModel {
  String current;
  String newPass;
  String repeat;

  ChangePasswordModel(this.current, this.newPass, this.repeat);

  void clear() {
    current = "";
    newPass = "";
    repeat = "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current'] = current;
    _data['new'] = newPass;
    _data['repeat'] = repeat;
    return _data;
  }
}
