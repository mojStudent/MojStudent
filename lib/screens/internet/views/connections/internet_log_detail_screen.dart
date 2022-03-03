import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class InternetLogDetailScreen extends StatelessWidget {
  final InternetConnectionLogModel log;
  const InternetLogDetailScreen({Key? key, required this.log})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              CategoryNameSliver(categoryName: "Osnovni podatki povezave"),
              TextRowSliver(
                title: "Stanje povezave",
                data: log.status == 0 ? 'aktivna' : 'prekinjena',
                icon: FlutterRemix.link,
              ),
              TextRowSliver(
                title: "ID povezave",
                data: log.id,
                icon: FlutterRemix.file_code_line,
              ),
              TextRowSliver(
                  title: "uporabniško ime",
                  data: log.username,
                  icon: FlutterRemix.user_3_line),
              TextRowSliver(
                title: "lokacija povezave",
                data: log.nas?.location ?? '',
                icon: FlutterRemix.route_line,
              ),
              TextRowSliver(
                title: "vzrok prekinitve",
                data: log.status == 0 ? '-/-' : log.terminate,
                icon: FlutterRemix.door_closed_line,
              ),
              CategoryNameSliver(categoryName: "Časovni okvir povezave"),
              TextRowSliver(
                title: "Čas vzpostavitve",
                data: log.start,
                icon: FlutterRemix.time_line,
              ),
              TextRowSliver(
                title: "Čas prekinitve",
                data: log.stop.isEmpty ? '-/-' : log.stop,
                icon: FlutterRemix.time_fill,
              ),
              TextRowSliver(
                title: "Trajanje povezave",
                data: log.status == 0 ? '-/-' : "${log.sessionTime} s",
                icon: FlutterRemix.timer_line,
              ),
              CategoryNameSliver(categoryName: "Podatki o napravi"),
              TextRowSliver(
                title: "Dodeljen ip naslov",
                data: log.ip,
                icon: FlutterRemix.map_pin_4_line,
              ),
              TextRowSliver(
                title: "MAC naslov povezave",
                data: log.device,
                icon: FlutterRemix.computer_line,
              ),
              //
              CategoryNameSliver(categoryName: "Podatki o napravi"),
              TextRowSliver(
                  title: "ime omrežne naprave",
                  data: log.nas?.shortName ?? '',
                  icon: FlutterRemix.router_line),
              TextRowSliver(
                title: "id povezovalne omrežne naprave",
                data: "${log.nas?.id}",
                icon: FlutterRemix.computer_line,
              ),
              TextRowSliver(
                title: "lokacija naprave",
                data: log.nas?.location ?? '',
                icon: FlutterRemix.route_line,
              ),
              TextRowSliver(
                title: "ip naprave",
                data: log.nas?.name ?? '',
                icon: FlutterRemix.computer_line,
              ),
              TextRowSliver(
                title: "oznaka vrat",
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
