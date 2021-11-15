import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  String? appName;
  String? version;
  String? buildNumber;
  bool loading = true;
  static const _url = "https://mojstudent.marela.team/tos";

  @override
  void initState() {
    PackageInfo.fromPlatform().then((packageInfo) => setState(() {
          appName = packageInfo.appName;
          version = packageInfo.version;
          buildNumber = packageInfo.buildNumber;
          loading = false;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.green,
        body: loading ? LoadingScreen() : _buildWithData());
  }

  Widget _buildWithData() {
    return CustomScrollView(
      slivers: [
        _header(),
        SliverToBoxAdapter(
          child: BoxWidget(
            title: "Verzija aplikacije",
            cardBody: Column(
              children: [
                RowBoxWidget(
                  description: "Verzija aplikacija",
                  data: version,
                ),
                RowBoxWidget(
                  description: "Verzija gradnje",
                  data: buildNumber,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BoxWidget(
            title: "O razvijalcu",
            cardBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowBoxWidget(
                  description: "Ime aplikacije",
                  data: appName,
                ),
                RowBoxWidget(
                  description: "Razvijalec aplikacije",
                  data: "MarelaTeam",
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BoxWidget(
            cardBody: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "2021 MarelaTeam",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "vse pravice pridržane",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async => await launch(_url),
                    child: Text(
                      "Z uporabo aplikacije se strinjate s pogoji uporabe",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        decoration: BoxDecoration(
            color: AppColors.raisinBlack.withOpacity(0.5),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/ikona.png',
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "O aplikaciji",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
