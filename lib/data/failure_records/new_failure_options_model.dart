class FailureOptions {
  FailureOptions({
    required this.subLocation,
  });

  late final List<SubLocationOption> subLocation;

  FailureOptions.fromJson(Map<String, dynamic> json) {
    subLocation = List.from(json['subLocation'])
        .map((e) => SubLocationOption.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subLocation'] = subLocation.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SubLocationOption {
  SubLocationOption({
    required this.value,
    required this.label,
    this.selected = false,
  });

  late final int value;
  late final String label;
  late final bool selected;

  SubLocationOption.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
    selected = json['selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['label'] = label;
    _data['selected'] = selected;
    return _data;
  }
}
