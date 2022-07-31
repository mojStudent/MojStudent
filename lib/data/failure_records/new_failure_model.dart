import 'package:moj_student/data/failure_records/new_failure_options_model.dart';

class NewFailureModel {
  NewFailureModel({
    required this.subLocation,
    required this.description,
  });

  late final SubLocationOption subLocation;
  late final String description;

  NewFailureModel.fromJson(Map<String, dynamic> json) {
    subLocation = SubLocationOption.fromJson(json['subLocation']);
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subLocation'] = subLocation.toJson();
    _data['description'] = description;
    return _data;
  }
}
