import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';

class InternetLogDetailScreen extends StatelessWidget {
  final InternetConnectionLogModel log;
  const InternetLogDetailScreen({Key? key, required this.log})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.success,
          elevation: 0,
          title: Text("Podrobnosti povezave"),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(padding: EdgeInsets.only(top: 20)),
            SliverToBoxAdapter(
              child: BoxWidget(
                title: "Osnovni podatki povezave",
                cardBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowBoxWidget(
                      description: "Stanje povezave",
                      data: log.status == 0 ? 'aktivna' : 'prekinjena',
                    ),
                    RowBoxWidget(
                      description: "ID povezave",
                      data: log.id,
                    ),
                    RowBoxWidget(
                      description: "Uporabniško ime",
                      data: log.username,
                    ),
                    RowBoxWidget(
                      description: "Lokacija povezave",
                      data: log.nas?.location,
                    ),
                    RowBoxWidget(
                      description: "Vzrok prekinitve",
                      data: log.status == 0 ? '-/-' : log.terminate,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BoxWidget(
                title: "Časovni okvir povezave",
                cardBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowBoxWidget(
                      description: "Čas vzpostavitve",
                      data: log.start,
                    ),
                    RowBoxWidget(
                      description: "Čas prekinitve",
                      data: log.stop.isEmpty ? '-/-' : log.stop,
                    ),
                    RowBoxWidget(
                      description: "Trajanje seje",
                      data: log.status == 0 ? '-/-' : "${log.sessionTime} s",
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BoxWidget(
                title: "Podatki o napravi",
                cardBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowBoxWidget(
                      description: "Dodeljen IP naslov",
                      data: log.ip,
                    ),
                    RowBoxWidget(
                      description: "MAC naslov naprave",
                      data: log.device,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BoxWidget(
                title: "Podatki o omrežni napravi",
                cardBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowBoxWidget(
                      description: "Ime omrežne naprave",
                      data: log.nas?.shortName,
                    ),
                    RowBoxWidget(
                      description: "ID povezovalne omrežne naprave",
                      data: "${log.nas?.id}",
                    ),
                    RowBoxWidget(
                      description: "Lokacija naprave",
                      data: log.nas?.location,
                    ),
                    RowBoxWidget(
                      description: "IP naprave",
                      data: log.nas?.name,
                    ),
                    RowBoxWidget(
                      description: "Oznaka vrat",
                      data: log.port,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(padding: EdgeInsets.only(top: 20)),
          ],
        ));
  }
}
