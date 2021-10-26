class InternetTrafficModel {
  late Days days;
  late List<Weeks> weeks = [];

  InternetTrafficModel({required this.days, required this.weeks});

  InternetTrafficModel.fromJson(Map<String, dynamic> json) {
    if (json['days'] != null) {
      days = Days.fromJson(json['days']);
    }
    if (json['weeks'] != null) {
      weeks = [];
      json['weeks'].forEach((v) {
        weeks.add(Weeks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['days'] = days.toJson();
    data['weeks'] = weeks.map((v) => v.toJson()).toList();
    return data;
  }
}

class Days {
  late Data data;

  Days({required this.data});

  Days.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  late List<String> labels = [];
  late List<Datasets> datasets = [];

  Data({required this.labels, required this.datasets});

  Data.fromJson(Map<String, dynamic> json) {
    labels = json['labels'].cast<String>();
    if (json['datasets'] != null) {
      json['datasets'].forEach((v) {
        datasets.add(Datasets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['labels'] = labels;
    data['datasets'] = datasets.map((v) => v.toJson()).toList();
    return data;
  }
}

class Datasets {
  late String label;
  late List<int> data = [];

  Datasets({required this.label, required this.data});

  Datasets.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label'] = label;
    data['data'] = data;
    return data;
  }
}

class Weeks {
  late String label;
  late Value value;
  late Value limit;
  late int progress;

  Weeks(
      {required this.label,
      required this.value,
      required this.limit,
      required this.progress});

  Weeks.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    if (json['value'] != null) {
      value = Value.fromJson(json['value']);
    }
    if (json['limit'] != null) {
      limit = Value.fromJson(json['limit']);
    }
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['label'] = label;
    data['value'] = value.toJson();
    data['limit'] = limit.toJson();
    data['progress'] = progress;
    return data;
  }
}

class Value {
  late int raw;
  late String human;

  Value({required this.raw, required this.human});

  Value.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    human = json['human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['raw'] = raw;
    data['human'] = human;
    return data;
  }
}
