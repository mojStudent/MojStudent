class InternetAdminLocationModel {
  InternetAdminLocationModel({
    required this.id,
    required this.name,
    required this.users,
    required this.campus,
    required this.label,
    required this.home,
  });

  late final int id;
  late final String name;
  late final int users;
  late final String campus;
  late final String label;
  late final bool home;

  InternetAdminLocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    users = json['users'];
    campus = json['campus'];
    label = json['label'];
    home = json['home'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['users'] = users;
    _data['campus'] = campus;
    _data['label'] = label;
    _data['home'] = home;
    return _data;
  }
}
