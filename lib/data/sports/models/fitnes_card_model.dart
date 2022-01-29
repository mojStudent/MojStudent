class FitnesCardModel {
  FitnesCardModel({
    required this.id,
    required this.owner,
    required this.status,
    required this.statusLabel,
    required this.created,
    required this.updated,
    required this.physical,
    required this.subscription,
    required this.price,
    required this.priceLabel,
    required this.ordersCount,
    required this.logs,
    required this.orders,
    required this.imageSrc,
  });
  late final int id;
  late final Owner owner;
  late final int status;
  late final String statusLabel;
  late final String created;
  late final String updated;
  late final bool physical;
  late final Subscription subscription;
  late final double price;
  late final String priceLabel;
  late final int ordersCount;
  late final List<Logs> logs;
  late final List<dynamic> orders;
  late final String imageSrc;
  
  FitnesCardModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    owner = Owner.fromJson(json['owner']);
    status = json['status'];
    statusLabel = json['statusLabel'];
    created = json['created'];
    updated = json['updated'];
    physical = json['physical'];
    subscription = Subscription.fromJson(json['subscription']);
    price = json['price'];
    priceLabel = json['priceLabel'];
    ordersCount = json['ordersCount'];
    logs = List.from(json['logs']).map((e)=>Logs.fromJson(e)).toList();
    orders = List.castFrom<dynamic, dynamic>(json['orders']);
    imageSrc = json['imageSrc'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['owner'] = owner.toJson();
    _data['status'] = status;
    _data['statusLabel'] = statusLabel;
    _data['created'] = created;
    _data['updated'] = updated;
    _data['physical'] = physical;
    _data['subscription'] = subscription.toJson();
    _data['price'] = price;
    _data['priceLabel'] = priceLabel;
    _data['ordersCount'] = ordersCount;
    _data['logs'] = logs.map((e)=>e.toJson()).toList();
    _data['orders'] = orders;
    _data['imageSrc'] = imageSrc;
    return _data;
  }
}

class Owner {
  Owner({
    required this.id,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.location,
    required this.locationId,
    required this.campus,
    required this.room,
  });
  late final int id;
  late final String username;
  late final String email;
  late final String firstname;
  late final String lastname;
  late final String location;
  late final int locationId;
  late final String campus;
  late final String room;
  
  Owner.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    location = json['location'];
    locationId = json['locationId'];
    campus = json['campus'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['email'] = email;
    _data['firstname'] = firstname;
    _data['lastname'] = lastname;
    _data['location'] = location;
    _data['locationId'] = locationId;
    _data['campus'] = campus;
    _data['room'] = room;
    return _data;
  }
}

class Subscription {
  Subscription({
    required this.id,
    required this.title,
  });
  late final int id;
  late final String title;
  
  Subscription.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    return _data;
  }
}

class Logs {
  Logs({
    required this.date,
    required this.message,
    required this.author,
  });
  late final Date date;
  late final String message;
  late final Author author;
  
  Logs.fromJson(Map<String, dynamic> json){
    date = Date.fromJson(json['date']);
    message = json['message'];
    author = Author.fromJson(json['author']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date.toJson();
    _data['message'] = message;
    _data['author'] = author.toJson();
    return _data;
  }
}

class Date {
  Date({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });
  late final String date;
  late final int timezoneType;
  late final String timezone;
  
  Date.fromJson(Map<String, dynamic> json){
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['timezone_type'] = timezoneType;
    _data['timezone'] = timezone;
    return _data;
  }
}

class Author {
  Author({
    required this.id,
    required this.label,
  });
  late final int id;
  late final String label;
  
  Author.fromJson(Map<String, dynamic> json){
    id = json['id'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['label'] = label;
    return _data;
  }
}