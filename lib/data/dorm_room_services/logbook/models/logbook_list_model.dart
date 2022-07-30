import 'package:moj_student/data/exceptions/empty_data_exception.dart';

class LogbookListModel {
  late final int count;
  late final int hits;
  late final int pp;
  late final int page;
  late final int pages;
  late final List<LogbookGetModel> results;

  LogbookListModel(
      {required this.count,
      required this.hits,
      required this.pp,
      required this.page,
      required this.pages,
      required this.results});

  LogbookListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    hits = json['hits'];
    pp = json['pp'];
    page = json['page'];
    pages = json['pages'];
    results = <LogbookGetModel>[];
    try {
      json['results'].forEach((v) {
        results.add(LogbookGetModel.fromJson(v));
      });
    } catch (e) {
      throw EmptyDataException();
    }
  }
}

class LogbookGetModel {
  late final String id;
  late final String location;
  late final String subLocation;
  late final String room;
  late final String date;
  late final String vandalType;
  late final String vandal;
  late final String description;
  late final String status;

  LogbookGetModel({
    required this.id,
    required this.location,
    required this.subLocation,
    required this.room,
    required this.date,
    required this.vandalType,
    required this.vandal,
    required this.description,
    required this.status,
  });

  LogbookGetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    subLocation = json['subLocation'];
    room = json['room'];
    date = json['date'];
    vandalType = json['vandalType'];
    vandal = json['vandal'];
    description = json['description'];
    status = json['status'];
  }
}
