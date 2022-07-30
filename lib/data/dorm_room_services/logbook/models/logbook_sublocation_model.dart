class LogbookSubLocation {
  late final int value;
  late final String label;
  bool? selected;

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
