import 'package:flutter/material.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:moj_student/screens/internet/views/charts/internet_traffic_chart.dart';

class InternetTrafficView extends StatefulWidget {
  InternetTrafficView({Key? key}) : super(key: key);

  @override
  _InternetTrafficViewState createState() => _InternetTrafficViewState();
}

class _InternetTrafficViewState extends State<InternetTrafficView> {
  InternetTrafficModel? data;

  @override
  Widget build(BuildContext context) {
    _getTrafficData();
    if (data == null) {
      return Container();
    } else {
      return Center(child: GroupedBarChart.withSampleData());
    }
  }

  Future<void> _getTrafficData() async {
    var internetRepo = InternetRepository(authRepository: AuthRepository());

    try {
      var d = await internetRepo.getInternetTraffic();
      setState(() {
        data = d;
      });
    } catch (e) {}
  }
}
