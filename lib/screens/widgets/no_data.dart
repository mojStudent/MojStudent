import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';

class NoData extends StatelessWidget {
  final String message;
  final IconData icon;

  const NoData(
      {Key? key,
      this.message = "Trenutno ni podatkov za prikaz",
      this.icon = Icons.document_scanner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 68,
              color: ThemeColors.jet,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 20, color: ThemeColors.jet),
            ),
          ],
        ));
  }
}
