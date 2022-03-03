import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/screens/internet/views/connections/internet_log_detail_screen.dart';
import 'package:moj_student/screens/internet/views/connections/internet_log_loaded_view.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';

class InternetLogView extends StatefulWidget {
  const InternetLogView({Key? key}) : super(key: key);

  @override
  _InternetLogViewState createState() => _InternetLogViewState();
}

class _InternetLogViewState extends State<InternetLogView> {
  List<InternetConnectionLogModel>? data;
  bool showOnlyActive = false;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      _getTrafficData();
    }

    return Scaffold(
        body: data != null
            ? InternetLogLoadedView(connections: data!)
            : LoadingScreen(
                withScaffold: false,
              ));
  }

  Future<void> _getTrafficData() async {
    var internetRepo = InternetRepository(authRepository: AuthRepository());

    try {
      var d = await internetRepo.getInternetConnections();
      setState(() {
        data = d;
      });
    } catch (e) {}
  }
}
