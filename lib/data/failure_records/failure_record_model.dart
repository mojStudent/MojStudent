import 'package:moj_student/data/exceptions/empty_data_exception.dart';

class FailurePaginationModel {
  FailurePaginationModel({
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
  late final List<FailureModel> results;

  FailurePaginationModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    hits = json['hits'];
    pp = json['pp'];
    page = json['page'];
    pages = json['pages'];
    if (json['results'] == null) {
      throw EmptyDataException();
    } else {
      results = List.from(json['results'])
          .map((e) => FailureModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['hits'] = hits;
    _data['pp'] = pp;
    _data['page'] = page;
    _data['pages'] = pages;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class FailureModel {
  FailureModel({
    required this.id,
    required this.location,
    required this.subLocation,
    required this.room,
    required this.date,
    required this.description,
    required this.status,
  });
  late final String id;
  late final String location;
  late final String subLocation;
  late final String room;
  late final String date;
  late final String description;
  late final String status;

  FailureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    subLocation = json['subLocation'];
    room = json['room'];
    date = json['date'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['location'] = location;
    _data['subLocation'] = subLocation;
    _data['room'] = room;
    _data['date'] = date;
    _data['description'] = description;
    _data['status'] = status;
    return _data;
  }
}
