import 'package:moj_student/helpers/compare_dates_only.dart';

class RestaurantDataModel {
  RestaurantDataModel({
    required this.weeklyMenu,
    required this.timetableModel,
  });

  late final List<WeeklyMenu> weeklyMenu;
  late final TimetableModel timetableModel;

  WeeklyMenu? getTodaysMenu() {
    final today = DateTime.now();
    for (var m in weeklyMenu) {
      if (m.date.isSameDate(today)) {
        return m;
      }
    }
    return null;
  }

  RestaurantDataModel.fromJson(Map<String, dynamic> json) {
    weeklyMenu = List.from(json['weeklyMenu'])
        .map((e) => WeeklyMenu.fromJson(e))
        .toList();
    timetableModel = TimetableModel.fromJson(json['timetableModel']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['weeklyMenu'] = weeklyMenu.map((e) => e.toJson()).toList();
    _data['timetableModel'] = timetableModel.toJson();
    return _data;
  }
}

class WeeklyMenu {
  WeeklyMenu({
    required this.stringDate,
    required this.date,
    required this.menus,
  });

  late final String stringDate;
  late final DateTime date;
  late final List<Menus> menus;

  WeeklyMenu.fromJson(Map<String, dynamic> json) {
    stringDate = json['stringDate'];
    date = DateTime.parse(json['date']);
    menus = List.from(json['menus']).map((e) => Menus.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['stringDate'] = stringDate;
    _data['date'] = date;
    _data['menus'] = menus.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Menus {
  Menus({
    required this.menuName,
    required this.menuItems,
  });

  late final String menuName;
  late final List<String> menuItems;

  Menus.fromJson(Map<String, dynamic> json) {
    menuName = json['menuName'];
    menuItems = List.castFrom<dynamic, String>(json['menuItems']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['menuName'] = menuName;
    _data['menuItems'] = menuItems;
    return _data;
  }
}

class TimetableModel {
  TimetableModel({
    required this.bar,
    required this.restaurant,
  });

  late final List<Bar> bar;
  late final List<Restaurant> restaurant;

  TimetableModel.fromJson(Map<String, dynamic> json) {
    bar = List.from(json['bar']).map((e) => Bar.fromJson(e)).toList();
    restaurant = List.from(json['restaurant'])
        .map((e) => Restaurant.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bar'] = bar.map((e) => e.toJson()).toList();
    _data['restaurant'] = restaurant.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Bar {
  Bar({
    required this.days,
    required this.hours,
  });

  late final String days;
  late final String hours;

  Bar.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['days'] = days;
    _data['hours'] = hours;
    return _data;
  }
}

class Restaurant {
  Restaurant({
    required this.days,
    required this.hours,
  });

  late final String days;
  late final String hours;

  Restaurant.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['days'] = days;
    _data['hours'] = hours;
    return _data;
  }
}
