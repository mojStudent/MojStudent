class InternetAdminNasModel {
  InternetAdminNasModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.location,
    required this.active,
  });
  late final int id;
  late final String name;
  late final String shortName;
  late final String location;
  late final bool active;
  
  InternetAdminNasModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    location = json['location'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['shortName'] = shortName;
    _data['location'] = location;
    _data['active'] = active;
    return _data;
  }
}