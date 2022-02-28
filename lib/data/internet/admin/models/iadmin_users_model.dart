class InternetAdminUsersPaginationModel {
  InternetAdminUsersPaginationModel({
    required this.hits,
    required this.page,
    required this.pages,
    required this.count,
    required this.results,
  });
  late final int hits;
  late final int page;
  late final int pages;
  late final int count;
  late final List<InternetAdminUserModel> results;

  InternetAdminUsersPaginationModel.fromJson(Map<String, dynamic> json) {
    hits = json['hits'];
    page = json['page'];
    pages = json['pages'];
    count = json['count'];
    results = List.from(json['results'])
        .map((e) => InternetAdminUserModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['hits'] = hits;
    _data['page'] = page;
    _data['pages'] = pages;
    _data['count'] = count;
    _data['results'] = results.map((e) => e.toJson()).toList();
    return _data;
  }
}

class InternetAdminUserModel {
  InternetAdminUserModel({
    required this.id,
    required this.username,
    this.email,
    required this.firstname,
    required this.lastname,
    required this.resetPassword,
    required this.status,
    required this.location,
    required this.locationId,
    required this.campus,
    required this.room,
    required this.emailVerified,
    this.emailDate,
    required this.locale,
    required this.internetAccess,
    this.phone,
    required this.mask,
    required this.bitmask,
    required this.roles,
    required this.foreigner,
    required this.internetAllowed,
    required this.CRMCategory,
    required this.api,
  });
  late final int id;
  late final String username;
  late final String? email;
  late final String firstname;
  late final String lastname;
  late final bool resetPassword;
  late final int status;
  late final String location;
  late final int locationId;
  late final String campus;
  late final String room;
  late final bool emailVerified;
  late final String? emailDate;
  late final String locale;
  late final bool internetAccess;
  late final String? phone;
  late final int mask;
  late final String bitmask;
  late final List<Roles> roles;
  late final bool foreigner;
  late final bool internetAllowed;
  late final String? CRMCategory;
  late final bool api;

  InternetAdminUserModel.fromJson(Map<String, dynamic> json) {
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
    emailDate = null;
    locale = json['locale'];
    internetAccess = json['internetAccess'];
    phone = json['phone'];
    mask = json['mask'];
    bitmask = json['bitmask'];
    roles = List.from(json['roles']).map((e) => Roles.fromJson(e)).toList();
    foreigner = json['foreigner'];
    internetAllowed = json['internetAllowed'];
    CRMCategory = json['CRMCategory'];
    api = json['api'];
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
    _data['CRMCategory'] = CRMCategory;
    _data['api'] = api;
    return _data;
  }
}

class Roles {
  Roles({
    required this.id,
    required this.name,
    required this.internet,
    required this.role,
    required this.count,
  });
  late final int id;
  late final String name;
  late final bool internet;
  late final String role;
  late final int count;

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
