import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/screens/internet/views/connections/internet_log_view.dart';
import 'package:moj_student/screens/internet/views/help/internet_help_view.dart';
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
        appBar: AppBar(
            title: Text("Internet"),
            centerTitle: true,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                FlutterRemix.arrow_left_s_line,
                color: Colors.white,
              ),
            ),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(
                    FlutterRemix.bar_chart_fill,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    FlutterRemix.file_list_3_fill,
                    color: Colors.white,
                  ),
                ),
                Tab(
                  icon: Icon(
                    FlutterRemix.question_fill,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
        body: TabBarView(
          children: [
            InternetTrafficView(),
            InternetLogView(),
            InternetHelpView()
          ],
        ),
      ),
    );
  }
}
