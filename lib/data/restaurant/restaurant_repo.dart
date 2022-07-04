import 'dart:convert';

import 'package:http_interceptor/http/http.dart';
import 'package:moj_student/data/exceptions/empty_data_exception.dart';
import 'package:moj_student/data/restaurant/restaurant_data_model.dart';

class RestaurantRepo {
  final client = InterceptedClient.build(
    interceptors: [],
  );

  static const _baseUrl = "https://mojstudent.sven.marela.team/roznakuhna/";

  Future<RestaurantDataModel> getRestaurantData() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json; charset=utf-8'
    };

    final response = await client.get(Uri.parse(_baseUrl), headers: headers);

    if (response.statusCode == 200) {
      try {
        var model = RestaurantDataModel.fromJson(jsonDecode(response.body));
        return model;
      } on EmptyDataException {
        rethrow;
      }
    } else {
      throw Exception(response.body);
    }
  }
}
