class IAdminErrorsPaginationModel {
  IAdminErrorsPaginationModel({
    required this.hits,
    required this.page,
    required this.pages,
    required this.count,
    required this.results,
  });
  late final String hits;
  late final int page;
  late final int pages;
  late final int count;
  late final List<IAdminErrorModel> results;

  IAdminErrorsPaginationModel.fromJson(Map<String, dynamic> json) {
    hits = json['hits'];
    page = json['page'];
    pages = json['pages'];
    count = json['count'];
    results = List.from(json['results'])
        .map((e) => IAdminErrorModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hits'] = hits;
    _data['page'] = page;
    _data['pages'] = pages;
    _data['count'] = count;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class IAdminErrorModel {
  IAdminErrorModel({
    required this.id,
    required this.username,
    required this.date,
    required this.mac,
    required this.nas,
    required this.port,
    required this.error,
    required this.description,
  });
  late final String id;
  late final String username;
  late final String date;
  late final String mac;
  late final String nas;
  late final String port;
  late final String error;
  late final String description;

  IAdminErrorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    date = json['date'];
    mac = json['mac'];
    nas = json['nas'];
    port = json['port'];
    error = json['error'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['date'] = date;
    _data['mac'] = mac;
    _data['nas'] = nas;
    _data['port'] = port;
    _data['error'] = error;
    _data['description'] = description;
    return _data;
  }
}
