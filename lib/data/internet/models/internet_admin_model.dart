class InternetAdministratorModel {
  InternetAdministratorModel({
    required this.name,
    required this.room,
  });

  late final String name;
  late final String room;

  InternetAdministratorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['room'] = room;
    return _data;
  }
}
