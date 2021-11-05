class SkodniZapisnikPaginationModel {
  SkodniZapisnikPaginationModel({
    required this.count,
    required this.hits,
    required this.pp,
    required this.page,
    required this.pages,
    required this.results,
  });
  late final int count;
  late final int hits;
  late final int pp;
  late final int page;
  late final int pages;
  late final List<DamageRecordModel> results;
  
  SkodniZapisnikPaginationModel.fromJson(Map<String, dynamic> json){
    count = json['count'];
    hits = json['hits'];
    pp = json['pp'];
    page = json['page'];
    pages = json['pages'];
    results = List.from(json['results']).map((e)=>DamageRecordModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['hits'] = hits;
    _data['pp'] = pp;
    _data['page'] = page;
    _data['pages'] = pages;
    _data['results'] = results.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class DamageRecordModel {
  DamageRecordModel({
    required this.mime,
    required this.filename,
    required this.date,
    required this.created,
    required this.modified,
    required this.partnerTitle,
    required this.url,
  });
  late final String mime;
  late final String filename;
  late final String date;
  late final String created;
  late final String modified;
  late final String partnerTitle;
  late final String url;
  
  DamageRecordModel.fromJson(Map<String, dynamic> json){
    mime = json['mime'];
    filename = json['filename'];
    date = json['date'];
    created = json['created'];
    modified = json['modified'];
    partnerTitle = json['partnerTitle'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mime'] = mime;
    _data['filename'] = filename;
    _data['date'] = date;
    _data['created'] = created;
    _data['modified'] = modified;
    _data['partnerTitle'] = partnerTitle;
    _data['url'] = url;
    return _data;
  }
}