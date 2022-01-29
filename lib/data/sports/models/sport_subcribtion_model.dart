class SportSubscriptionModel {
  SportSubscriptionModel({
    required this.id,
    required this.capacity,
    required this.sold,
    required this.free,
    required this.soldOut,
    required this.price,
    required this.priceCode,
    required this.published,
    required this.author,
    required this.title,
    required this.body,
    required this.created,
    required this.updated,
    required this.subscribed,
    required this.manager,
    required this.attachments,
  });
  late final int id;
  late final int capacity;
  late final int sold;
  late final int free;
  late final bool soldOut;
  late final int price;
  late final String priceCode;
  late final bool published;
  late final String author;
  late final String title;
  late final String body;
  late final String created;
  late final String updated;
  late final bool subscribed;
  late final bool manager;
  late final List<dynamic> attachments;
  
  SportSubscriptionModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    capacity = json['capacity'];
    sold = json['sold'];
    free = json['free'];
    soldOut = json['soldOut'];
    price = json['price'];
    priceCode = json['priceCode'];
    published = json['published'];
    author = json['author'];
    title = json['title'];
    body = json['body'];
    created = json['created'];
    updated = json['updated'];
    subscribed = json['subscribed'];
    manager = json['manager'];
    attachments = List.castFrom<dynamic, dynamic>(json['attachments']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['capacity'] = capacity;
    _data['sold'] = sold;
    _data['free'] = free;
    _data['soldOut'] = soldOut;
    _data['price'] = price;
    _data['priceCode'] = priceCode;
    _data['published'] = published;
    _data['author'] = author;
    _data['title'] = title;
    _data['body'] = body;
    _data['created'] = created;
    _data['updated'] = updated;
    _data['subscribed'] = subscribed;
    _data['manager'] = manager;
    _data['attachments'] = attachments;
    return _data;
  }
}