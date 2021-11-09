class InternetHelpMasterModel {
  InternetHelpMasterModel({
    required this.help,
    required this.detected,
  });
  late final List<Help> help;
  late final Detected detected;
  
  InternetHelpMasterModel.fromJson(Map<String, dynamic> json){
    help = List.from(json['help']).map((e)=>Help.fromJson(e)).toList();
    detected = Detected.fromJson(json['detected']);
  }

}

class Help {
  Help({
    required this.name,
    required this.path,
    required this.image,
    required this.os,
  });
  late final String name;
  late final String path;
  late final String image;
  late final List<Os> os;
  
  Help.fromJson(Map<String, dynamic> json){
    name = json['name'];
    path = json['path'];
    image = json['image'];
    os = List.from(json['os']).map((e)=>Os.fromJson(e)).toList();
  }
}

class Os {
  Os({
    required this.name,
    required this.path,
    required this.type,
  });
  late final String name;
  late final String path;
  late final String type;
  
  Os.fromJson(Map<String, dynamic> json){
    name = json['name'];
    path = json['path'];
    type = json['type'];
  }
}

class Detected {
  Detected({
    required this.os,
    required this.browser,
  });
  late final String os;
  late final String browser;
  
  Detected.fromJson(Map<String, dynamic> json){
    os = json['os'];
    browser = json['browser'];
  }
}