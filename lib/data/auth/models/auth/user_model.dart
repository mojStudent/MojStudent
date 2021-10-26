class UserModel {
  UserModel({
    this.id,
    this.username,
    this.email,
    this.firstname,
    this.lastname,
    this.resetPassword,
    this.status,
    this.location,
    this.locationId,
    this.campus,
    this.room,
    this.emailVerified,
    this.emailDate,
    this.locale,
    this.internetAccess,
    this.phone,
    this.mask,
    this.bitmask,
    this.roles = const [],
    this.foreigner,
    this.internetAllowed,
    this.CRMId,
    this.CRMInvalidDate,
    this.CRMCategory,
    this.api,
    this.ip,
    this.signature,
    this.subscriptions = const [],
    this.notifications,
  });
  int? id;
  String? username;
  String? email;
  String? firstname;
  String? lastname;
  bool? resetPassword;
  int? status;
  String? location;
  int? locationId;
  String? campus;
  String? room;
  bool? emailVerified;
  String? emailDate;
  String? locale;
  bool? internetAccess;
  String? phone;
  int? mask;
  String? bitmask;
  List<Roles> roles = [];
  bool? foreigner;
  bool? internetAllowed;
  String? CRMId;
  DateTime? CRMInvalidDate;
  String? CRMCategory;
  bool? api;
  String? ip;
  String? signature;
  List<Subscriptions> subscriptions = [];
  int? notifications;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    resetPassword = json['resetPassword'];
    status = json['status'];
    location = json['location'];
    locationId = json['locationId'];
    campus = json['campus'];
    room = json['room'];
    emailVerified = json['emailVerified'];
    emailDate = json['emailDate'];
    locale = json['locale'];
    internetAccess = json['internetAccess'];
    phone = json['phone'];
    mask = json['mask'];
    bitmask = json['bitmask'];
    roles = List.from(json['roles']).map((e) => Roles.fromJson(e)).toList();
    foreigner = json['foreigner'];
    internetAllowed = json['internetAllowed'];
    CRMId = json['CRMId'];
    CRMInvalidDate = json['CRMInvalidDate'];
    CRMCategory = json['CRMCategory'];
    api = json['api'];
    ip = json['ip'];
    signature = json['signature'];
    subscriptions = List.from(json['subscriptions'])
        .map((e) => Subscriptions.fromJson(e))
        .toList();
    notifications = json['notifications'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['resetPassword'] = resetPassword;
    _data['status'] = status;
    _data['location'] = location;
    _data['locationId'] = locationId;
    _data['campus'] = campus;
    _data['room'] = room;
    _data['emailVerified'] = emailVerified;
    _data['emailDate'] = emailDate;
    _data['locale'] = locale;
    _data['internetAccess'] = internetAccess;
    _data['phone'] = phone;
    _data['mask'] = mask;
    _data['bitmask'] = bitmask;
    _data['roles'] = roles.map((e) => e.toJson()).toList();
    _data['foreigner'] = foreigner;
    _data['internetAllowed'] = internetAllowed;
    _data['CRMId'] = CRMId;
    _data['CRMInvalidDate'] = CRMInvalidDate;
    _data['CRMCategory'] = CRMCategory;
    _data['api'] = api;
    _data['ip'] = ip;
    _data['signature'] = signature;
    _data['subscriptions'] = subscriptions.map((e) => e.toJson()).toList();
    _data['notifications'] = notifications;
    return _data;
  }
}

class Roles {
  Roles({
    this.id,
    this.name,
    this.internet,
    this.role,
    this.count,
  });
  int? id;
  String? name;
  bool? internet;
  String? role;
  int? count;

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    internet = json['internet'];
    role = json['role'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['internet'] = internet;
    _data['role'] = role;
    _data['count'] = count;
    return _data;
  }
}

class Subscriptions {
  Subscriptions({
    this.id,
    this.name,
    this.locked,
    this.selected,
  });
  int? id;
  String? name;
  bool? locked;
  bool? selected;

  Subscriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    locked = json['locked'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['locked'] = locked;
    _data['selected'] = selected;
    return _data;
  }
}
