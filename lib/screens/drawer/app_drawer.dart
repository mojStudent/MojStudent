import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/avatars/avatar_repo.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Drawer(
        backgroundColor: AppColors.jet,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                w * 0.03,
                h * 0.08,
                w * 0.03,
                h * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: AppColors.ghostWhite,
                      child: SvgPicture.network(
                          AvatarRepo.getImgUrlForSeed("JAKOB-MARUŠIČ")),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "JAKOB MARUŠIČ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                          Text(
                            "Dom 5 (Rožna dolina), 0304",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.015),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    _buttonsGroup(w, h, name: "bivanje", buttons: [
                      _serviceTextButton(w,
                          icon: FlutterRemix.notification_3_fill,
                          name: "Obvestila",
                          onClick: () => Navigator.of(context)
                              .pushNamed("/notifications")),
                      // _serviceTextButton(w,
                      //     icon: FlutterRemix.restaurant_2_fill,
                      //     name: "Rožna kuhnja",
                      //     onClick: () => null),
                      _serviceTextButton(w,
                          icon: FlutterRemix.error_warning_fill,
                          name: "Okvare",
                          onClick: () =>
                              Navigator.of(context).pushNamed("/failures")),
                      _serviceTextButton(w,
                          icon: FlutterRemix.flood_fill,
                          name: "Škodni zapisniki",
                          onClick: () =>
                              Navigator.of(context).pushNamed("/damages")),
                    ]),
                    //
                    _buttonsGroup(w, h, name: "internetni dostop", buttons: [
                      _serviceTextButton(w,
                          icon: FlutterRemix.bar_chart_2_fill,
                          name: "Statistika prometa",
                          onClick: () =>
                              Navigator.of(context).pushNamed("/internet")),
                      _serviceTextButton(w,
                          icon: FlutterRemix.file_history_fill,
                          name: "Prijave",
                          onClick: () =>
                              Navigator.of(context).pushNamed("/internet")),
                      _serviceTextButton(w,
                          icon: FlutterRemix.questionnaire_fill,
                          name: "Pomoč",
                          onClick: () =>
                              Navigator.of(context).pushNamed("/internet")),
                    ]),
                    //
                    // _buttonsGroup(w, h, name: "Šport", buttons: [
                    //   _serviceTextButton(w,
                    //       icon: FlutterRemix.timer_fill,
                    //       name: "Urnik",
                    //       onClick: () => null),
                    //   _serviceTextButton(w,
                    //       icon: FlutterRemix.basketball_fill,
                    //       name: "Naročnine",
                    //       onClick: () => null),
                    //   _serviceTextButton(w,
                    //       icon: FlutterRemix.bank_card_2_fill,
                    //       name: "Fitnes kartica",
                    //       onClick: () => null),
                    // ]),
                    //
                    _buttonsGroup(w, h, name: "nastavitve", buttons: [
                      _serviceTextButton(w,
                          icon: FlutterRemix.user_3_fill,
                          name: "Profil",
                          onClick: () =>
                              Navigator.of(context).pushNamed("/profile")),
                      // _serviceTextButton(w,
                      //     icon: FlutterRemix.settings_2_fill,
                      //     name: "Nastavitve aplikacije",
                      //     onClick: () => null),
                    ]),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(
                    top: h * 0.05, left: w * 0.05, right: w * 0.05),
                child: Row(
                  children: [
                    Icon(FlutterRemix.app_store_line, color: Colors.white),
                    SizedBox(
                      width: w * 0.1,
                    ),
                    Text(
                      "O aplikaciji",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: h * 0.05,
                    left: w * 0.05,
                    right: w * 0.05,
                    top: h * 0.02),
                child: Row(
                  children: [
                    Icon(FlutterRemix.logout_box_r_line, color: Colors.white),
                    SizedBox(
                      width: w * 0.1,
                    ),
                    Text(
                      "Odjava",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  SliverPadding _buttonsGroup(double w, double h,
      {required String name, required List<TextButton> buttons}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.toUpperCase(),
              style: TextStyle(
                  fontSize: 10,
                  color: AppColors.ghostWhite[600],
                  fontWeight: FontWeight.w800),
            ),
            Column(children: buttons)
          ],
        ),
      ),
    );
  }

  TextButton _serviceTextButton(double w,
      {required IconData icon,
      required String name,
      required Function onClick}) {
    return TextButton(
        onPressed: () => onClick(),
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(left: 15),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: w * 0.02,
            ),
            Text(
              name,
              style: TextStyle(color: Colors.white),
            )
          ],
        ));
  }
}
