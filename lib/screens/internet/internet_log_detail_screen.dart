import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/category_name_container.dart';
import 'package:moj_student/screens/widgets/data_containers/data_row_with_description.dart';
import 'package:moj_student/screens/widgets/data_containers/row_widget_container.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class InternetLogDetailScreen extends StatelessWidget {
  final InternetConnectionLogModel log;
  const InternetLogDetailScreen({Key? key, required this.log})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        AppHeader(title: "Podrobnosti povezave"),
        Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPadding(padding: EdgeInsets.only(top: 20)),
              CategoryNameContainer(categoryName: "Osnovni podatki povezave"),
              DataRowWidget(
                dataName: "Stanje povezave",
                data: log.status == 0 ? 'aktivna' : 'prekinjena',
                icon: FlutterRemix.link,
              ),
              DataRowWidget(
                dataName: "ID povezave",
                data: log.id,
                icon: FlutterRemix.file_code_line,
              ),
              DataRowWidget(
                  dataName: "uporabniško ime",
                  data: log.username,
                  icon: FlutterRemix.user_3_line),
              DataRowWidget(
                dataName: "lokacija povezave",
                data: log.nas?.location ?? '',
                icon: FlutterRemix.route_line,
              ),
              DataRowWidget(
                dataName: "vzrok prekinitve",
                data: log.status == 0 ? '-/-' : log.terminate,
                icon: FlutterRemix.door_closed_line,
              ),
              CategoryNameContainer(categoryName: "Časovni okvir povezave"),
              DataRowWidget(
                dataName: "Čas vzpostavitve",
                data: log.start,
                icon: FlutterRemix.time_line,
              ),
              DataRowWidget(
                dataName: "Čas prekinitve",
                data: log.stop.isEmpty ? '-/-' : log.stop,
                icon: FlutterRemix.time_fill,
              ),
              DataRowWidget(
                dataName: "Trajanje povezave",
                data: log.status == 0 ? '-/-' : "${log.sessionTime} s",
                icon: FlutterRemix.timer_line,
              ),
              CategoryNameContainer(categoryName: "Podatki o napravi"),
              DataRowWidget(
                dataName: "Dodeljen ip naslov",
                data: log.ip,
                icon: FlutterRemix.map_pin_4_line,
              ),
              DataRowWidget(
                dataName: "MAC naslov povezave",
                data: log.device,
                icon: FlutterRemix.computer_line,
              ),
              //
              CategoryNameContainer(categoryName: "Podatki o napravi"),
              DataRowWidget(
                  dataName: "ime omrežne naprave",
                  data: log.nas?.shortName ?? '',
                  icon: FlutterRemix.router_line),
              DataRowWidget(
                dataName: "id povezovalne omrežne naprave",
                data: "${log.nas?.id}",
                icon: FlutterRemix.computer_line,
              ),
              DataRowWidget(
                dataName: "lokacija naprave",
                data: log.nas?.location ?? '',
                icon: FlutterRemix.route_line,
              ),
              DataRowWidget(
                dataName: "ip naprave",
                data: log.nas?.name ?? '',
                icon: FlutterRemix.computer_line,
              ),
              DataRowWidget(
                dataName: "oznaka vrat",
                data: log.port,
                icon: FlutterRemix.door_line,
              ),

              SliverPadding(padding: EdgeInsets.only(top: h * 0.05)),
            ],
          ),
        ),
      ],
    ));
  }
}
