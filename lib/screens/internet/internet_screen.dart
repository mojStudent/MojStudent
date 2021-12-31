import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/internet/views/help/internet_help_view.dart';
import 'package:moj_student/screens/internet/views/internet_log_view.dart';
import 'package:moj_student/screens/internet/views/internet_traffic_view.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({Key? key}) : super(key: key);

  @override
  _InternetScreenState createState() => _InternetScreenState();
} 

class _InternetScreenState extends State<InternetScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.green,
        appBar: AppBar(
            title: Text("Internet"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.raisinBlack[500],
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.bar_chart),
                  text: "Promet",
                ),
                Tab(
                  icon: Icon(Icons.list_alt_outlined),
                  text: "Prijave",
                ),
                Tab(
                  icon: Icon(Icons.help_center_outlined),
                  text: "Pomoč",
                ),
              ],
            )),
        body: TabBarView(children: [
          InternetTrafficView(),
          InternetLogView(),
          InternetHelpView()
        ],),
      ),
    );
  }
}
