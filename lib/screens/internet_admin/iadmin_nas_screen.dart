import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class InternetAdminNasScreen extends StatelessWidget {
  const InternetAdminNasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        AppHeader(title: "NAS status"),
        Expanded(
            child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            RowSliver(
              title: "dom 1",
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.computer_line,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text("88.200.100.99")
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.database_2_line,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text("sbl-1-1")
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.checkbox_circle_fill,
                        size: 20,
                        color: ThemeColors.primary,
                      ),
                      SizedBox(width: 10),
                      Text("Gor", style: TextStyle(fontWeight: FontWeight.w800))
                    ],
                  ),
                ],
              ),
            ),
            RowSliver(
              title: "dom 1",
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.computer_line,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text("88.200.100.99")
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.database_2_line,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text("sbl-1-1")
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        FlutterRemix.error_warning_fill,
                        size: 20,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Dol",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
