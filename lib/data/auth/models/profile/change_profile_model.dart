import 'package:moj_student/data/auth/models/auth/user_model.dart';

class ChangeProfileModel {
  ChangeProfileModel({
    this.phone,
    this.subscriptions,
  });

  String? phone;
  List<Subscriptions>? subscriptions;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phone'] = phone;
    if (subscriptions != null) {
      _data['subscriptions'] = subscriptions!.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}
