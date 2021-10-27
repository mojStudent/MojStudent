import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/constants/math.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:moj_student/screens/internet/internet_log_detail_screen.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';

class InternetLogView extends StatefulWidget {
  InternetLogView({Key? key}) : super(key: key);

  @override
  _InternetLogViewState createState() => _InternetLogViewState();
}

class _InternetLogViewState extends State<InternetLogView> {
  List<InternetConnectionLogModel>? data;

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return ListView.builder(
        itemCount: data!.length,
        itemBuilder: (context, index) {
          var log = data![index];
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
                vertical: MediaQuery.of(context).size.height * 0.005),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InternetLogDetailScreen(log: log),
                      ),
                    ),
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(log.status == 0 ? 0 : 5, 10, 5, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [_connectionTypeIndicator(log)],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          log.status == 0
                              ? _activeConnectionData(log)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${log.sessionTime} s",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.timer,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${log.terminate}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ],
                  ),
                )),
          );
        },
      );
    } else {
      _getTrafficData();
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget _connectionTypeIndicator(InternetConnectionLogModel log) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                log.status == 0
                    ? Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 18,
                        ),
                      )
                    : Container(),
                Text(
                  "${log.nas?.location}",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          log.nas?.location == 'WiFi' ? Icons.wifi : Icons.cable,
          color: Colors.black,
          size: 18,
        ),
      ],
    );
  }

  Widget _activeConnectionData(InternetConnectionLogModel log) {
    return Row(
      children: [
        Text(
          "IP: ${log.ip}",
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.network_check_outlined,
          color: Colors.black,
          size: 20,
        ),
      ],
    );
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
