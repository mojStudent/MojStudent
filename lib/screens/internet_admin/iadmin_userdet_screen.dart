import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class InternetAdminUserDetailScreen extends StatelessWidget {
  const InternetAdminUserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Pregled uporabnika"),
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
                    FlutterRemix.user_fill,
                    color: Colors.white,
                  ),
                ),
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
              ],
            )),
        body: Column(children: [
          Expanded(
              child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              CategoryNameSliver(categoryName: "Podatki o uporabniku"),
              TextRowSliver(
                title: "Ime in priimek",
                data: "Jakob Marušič".toUpperCase(),
                icon: FlutterRemix.user_line,
              ),
              TextRowSliver(
                title: "Lokacija",
                data: "Dom 5, Rožna dolina",
                icon: FlutterRemix.building_line,
              ),
              TextRowSliver(
                title: "Soba",
                data: "304",
                icon: FlutterRemix.home_3_line,
              ),
              TextRowSliver(
                title: "Uporabniško ime",
                data: "jakmarusic@sd-lj.si",
                icon: FlutterRemix.passport_line,
              ),
              TextRowSliver(
                  title: "E-pošta",
                  data: "jakob.marusic17@gmail.com",
                  icon: FlutterRemix.mail_line),
              TextRowSliver(
                title: "Telefon",
                data: "031708115",
                icon: FlutterRemix.phone_line,
              ),
            ],
          ))
        ]),
      ),
    );
  }
}
