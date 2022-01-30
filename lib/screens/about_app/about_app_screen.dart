import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/category_name_container.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
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
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        // backgroundColor: Color.alphaBlend(ThemeColors.primary.withOpacity(0.7), Colors.white),
        backgroundColor: ThemeColors.background,
        body: loading ? LoadingScreen() : _buildWithData(h, w));
  }

  Widget _buildWithData(double h, double w) {
    return Column(
      children: [
        AppHeader(title: "o aplikaciji"),
        Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              CategoryNameSliver(categoryName: "Verzija aplikacije"),
              TextRowSliver(data: "$version", title: "Verzija aplikacije"),
              TextRowSliver(data: "$buildNumber", title: "Verzija gradnje"),
              CategoryNameSliver(categoryName: "O razvijalcu"),
              TextRowSliver(data: appName ?? '', title: "Ime aplikacije"),
              TextRowSliver(
                  data: "MarelaTeam", title: "Razvijalec aplikacije"),
              SliverPadding(
                padding: EdgeInsets.only(bottom: h * 0.05),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: w * 0.06, vertical: h * 0.02),
                    margin: EdgeInsets.symmetric(
                        horizontal: w * 0.06, vertical: h * 0.0075),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "2021 MarelaTeam",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
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
                                color: ThemeColors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
