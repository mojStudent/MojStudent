class InternetConnectionLogModel {
  late String id;
  late String username;
  late String start;
  late String stop;
  late int sessionTime;
  late String device;
  late String terminate;
  late int status;
  late String ip;
  late String port;
  Nas? nas;

  InternetConnectionLogModel({
    required this.id,
    required this.username,
    this.start = '',
    this.stop = '',
    this.sessionTime = -1,
    this.device = '',
    this.terminate = '',
    this.status = -1,
    this.ip = '',
    this.port = '',
    this.nas,
  });

  InternetConnectionLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? -1;
    username = json['username'] ?? '';
    start = json['start'] ?? '';
    stop = json['stop'] ?? '';
    sessionTime = json['sessionTime'] ?? -1;
    device = json['device'] ?? '';
    terminate = json['terminate'] ?? '';
    status = json['status'] ?? -1;
    ip = json['ip'] ?? '';
    port = json['port'] ?? '';
    nas = json['nas'] != null ? Nas.fromJson(json['nas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['username'] = username;
    data['start'] = start;
    data['stop'] = stop;
    data['sessionTime'] = sessionTime;
    data['device'] = device;
    data['terminate'] = terminate;
    data['status'] = status;
    data['ip'] = ip;
    data['port'] = port;
    if (nas != null) {
      data['nas'] = nas?.toJson();
    }
    return data;
  }
}

class Nas {
  late int id;
  late String name;
  late String shortName;
  late String location;

  Nas({
    this.id = -1,
    this.name = '',
    this.shortName = '',
    this.location = '',
  });

  Nas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['location'] = location;
    return data;
  }
}
