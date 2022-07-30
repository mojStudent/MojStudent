class VandalType {
  late final int value;
  late final String label;
  bool? selected;

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
