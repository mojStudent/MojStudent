import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_sublocation_model.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_vandal_type.dart';

class LogbookAddOptionsModel {
  late final List<LogbookSubLocation> subLocation;
  late final List<VandalType> vandalType;

  LogbookAddOptionsModel({
    required this.subLocation,
    required this.vandalType,
  });

  LogbookAddOptionsModel.fromJson(Map<String, dynamic> json)
      : subLocation = (json['subLocation'] as List?)
                ?.map(
                  (dynamic e) =>
                      LogbookSubLocation.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            [],
        vandalType = (json['vandalType'] as List?)
                ?.map(
                  (dynamic e) => VandalType.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            [];

  Map<String, dynamic> toJson() => {
        'LogbookSubLocation': subLocation?.map((e) => e.toJson()).toList(),
        'vandalType': vandalType?.map((e) => e.toJson()).toList()
      };
}
