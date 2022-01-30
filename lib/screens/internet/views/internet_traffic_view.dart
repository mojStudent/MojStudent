import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/constants/math.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:moj_student/screens/internet/views/charts/internet_traffic_chart.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';

class InternetTrafficView extends StatefulWidget {
  const InternetTrafficView({Key? key}) : super(key: key);

  @override
  _InternetTrafficViewState createState() => _InternetTrafficViewState();
}

class _InternetTrafficViewState extends State<InternetTrafficView> {
  InternetTrafficModel? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      _getTrafficData();
      return LoadingScreen();
    } else {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(padding: EdgeInsets.only(top: 20)),
          RowSliver(
            title: "Prenos gor v tem tednu",
            icon: FlutterRemix.upload_2_line,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data?.weeks[0].value.human}",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      " / ${data?.weeks[0].limit.human}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: LinearProgressIndicator(
                    color: Colors.red,
                    backgroundColor: AppColors.green[400],
                    minHeight: 10,
                    value: (data?.weeks[0].progress ?? 0) / 100.0,
                  ),
                )
              ],
            ),
          ),
          RowSliver(
            title: "Količina prenosa",
            icon: FlutterRemix.arrow_up_down_line,
            child: Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: InternetTrafficChart.createChart(data!)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Prenos gor"),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 15,
                      height: 10,
                      color: Colors.red,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Prenos dol"),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 15,
                      height: 10,
                      color: AppColors.success,
                    ),
                  ],
                ),
              ],
            ),
          ),
          RowSliver(
            title: "Prenos v tem tednu",
            icon: FlutterRemix.loader_2_line,
            child: Column(children: [
              for (int i = (data?.days.data.labels.length ?? 7) - 7;
                  i < (data?.days.data.labels.length ?? 0);
                  i++)
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${data?.days.data.labels[i]}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Column(children: [
                            Row(
                              children: [
                                Text(
                                  "${AppMath.divideAndFormat(data: data?.days.data.datasets[1].data[i] ?? 0)} GB",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Icon(
                                  Icons.download,
                                  color: AppColors.green[700],
                                  size: 20,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${AppMath.divideAndFormat(data: data?.days.data.datasets[0].data[i] ?? 0)} GB",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Icon(
                                  Icons.file_upload,
                                  color: Colors.red[300],
                                  size: 20,
                                ),
                              ],
                            ),
                          ])
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    )
                  ],
                )
            ]),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 20)),
        ],
      );
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
