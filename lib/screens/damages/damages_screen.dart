import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/drawer/app_drawer.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';

class DamagesScreen extends StatefulWidget {
  DamagesScreen({Key? key}) : super(key: key);

  @override
  _DamagesScreenState createState() => _DamagesScreenState();
}

class _DamagesScreenState extends State<DamagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Škodni zapisniki"),
        backgroundColor: AppColors.success,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: NotSupported()
    );
  }
}
