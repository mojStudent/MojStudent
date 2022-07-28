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

class LogbookSubLocation {
  late final int value;
  late final String label;
  final bool? selected;

  LogbookSubLocation({
    required this.value,
    required this.label,
    this.selected,
  });

  LogbookSubLocation.fromJson(Map<String, dynamic> json)
      : value = json['value'] as int,
        label = json['label'] as String,
        selected = json['selected'] as bool?;

  Map<String, dynamic> toJson() =>
      {'value': value, 'label': label, 'selected': selected};
}

class VandalType {
  late final int value;
  late final String label;
  final bool? selected;

  VandalType({
    required this.value,
    required this.label,
    this.selected,
  });

  VandalType.fromJson(Map<String, dynamic> json)
      : value = json['value'] as int,
        label = json['label'] as String,
        selected = json['selected'] as bool?;

  Map<String, dynamic> toJson() =>
      {'value': value, 'label': label, 'selected': selected};
}
