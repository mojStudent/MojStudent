import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/drawer/app_drawer.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';

class FailuresScreen extends StatefulWidget {
  FailuresScreen({Key? key}) : super(key: key);

  @override
  _FailuresScreenState createState() => _FailuresScreenState();
}

class _FailuresScreenState extends State<FailuresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Okvare"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.success,
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        backgroundColor: AppColors.blue,
        child: Icon(Icons.add),
      ),
      body: NotSupported(),
    );
  }
}
