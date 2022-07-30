import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_sublocation_model.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_vandal_type.dart';

class LogbookModel {
  late LogbookSubLocation subLocation;
  late VandalType vandalType;
  String? room;
  String? vandal;
  String? description;

  LogbookModel({
    required this.subLocation,
    required this.vandalType,
    this.room,
    this.vandal,
    this.description,
  });

  LogbookModel.fromJson(Map<String, dynamic> json) {
    subLocation = LogbookSubLocation.fromJson(json['subLocation']);
    vandalType = VandalType.fromJson(json['vandalType']);
    room = json['room'];
    vandal = json['vandal'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subLocation'] = subLocation!.toJson();
    data['vandalType'] = vandalType!.toJson();
    data['room'] = room;
    data['vandal'] = vandal;
    data['description'] = description;
    return data;
  }
}
