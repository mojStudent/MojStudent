import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/row_button_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class InternetAdminErrorScreen extends StatelessWidget {
  const InternetAdminErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(children: [
        AppHeader(title: "Napake"),
        Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              RowSliver(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "2022-02-22T18:36:04",
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(FlutterRemix.passport_line, size: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            "jakmarusic@sd-lj.si",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(FlutterRemix.information_line, size: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            "Auth: Login incorrect: [krifel@sd-lj.si]",
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                onClick: () => BottomModal.showCustomModal(context,
                    height: h * 0.7,
                    color: Colors.white,
                    body: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                "podrobnosti napake".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SliverPadding(
                              padding: EdgeInsets.only(
                                  left: w * 0.04, right: w * 0.04),
                              sliver: SliverToBoxAdapter(
                                child: Divider(
                                  thickness: 1.5,
                                  color: ThemeColors.jet.withOpacity(0.25),
                                ),
                              )),
                          TextRowSliver(
                            title: "Čas",
                            data: "2022-02-22T18:36:04",
                            icon: FlutterRemix.time_line,
                          ),
                          TextRowSliver(
                            title: "Uporabniško ime",
                            data: "jakmarusic@sd-lj.si",
                            icon: FlutterRemix.passport_line,
                          ),
                          TextRowSliver(
                            title: "NAS",
                            data: "wlc-gerbi, 1",
                            icon: FlutterRemix.database_2_line,
                          ),
                          TextRowSliver(
                            title: "MAC",
                            data: "ec-89-14-60-85-cf",
                            icon: FlutterRemix.computer_line,
                          ),
                          TextRowSliver(
                            title: "napaka",
                            data:
                                "Tue Feb 22 18:36:03 2022 : Auth: Login incorrect: [krifel@sd-lj.si] (from client wlc-gerbi port 1 cli ec-89-14-60-85-cf)",
                            icon: FlutterRemix.error_warning_line,
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BottomModal.showCustomModal(context,
            height: h * 0.9,
            color: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "iskanje".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                      sliver: SliverToBoxAdapter(
                        child: Divider(
                          thickness: 1.5,
                          color: ThemeColors.jet.withOpacity(0.25),
                        ),
                      )),
                  RowSliver(
                    title: "Uporabniško ime",
                    icon: FlutterRemix.passport_line,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                          label: Text("Iskanje po uporabniškem imenu"),
                          border: InputBorder.none),
                      validator: (value) => null,
                      onChanged: (value) => null,
                    ),
                  ),
                  RowSliver(
                    title: "MAC",
                    icon: FlutterRemix.computer_line,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                          label: Text("Iskanje po MAC naslovu"),
                          border: InputBorder.none),
                      validator: (value) => null,
                      onChanged: (value) => null,
                    ),
                  ),
                  RowSliver(
                    title: "Opis napake",
                    icon: FlutterRemix.error_warning_line,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                          label: Text("Iskanje po opisu napake"),
                          border: InputBorder.none),
                      validator: (value) => null,
                      onChanged: (value) => null,
                    ),
                  ),
                  RowButtonSliver(
                    title: "Poišči",
                    onPressed: () => null,
                    icon: FlutterRemix.search_2_line,
                  )
                ],
              ),
            )),
        child: Icon(
          FlutterRemix.search_2_line,
          color: Colors.white,
        ),
        backgroundColor: ThemeColors.primary,
        elevation: 0,
      ),
    );
  }
}
