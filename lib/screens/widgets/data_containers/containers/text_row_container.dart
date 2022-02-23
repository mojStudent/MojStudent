import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';

class TextRowContainer extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String data;

  const TextRowContainer(
      {Key? key, required this.data, required this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return RowContainer(
      title: title,
      icon: icon,
      child: Padding(
        padding: EdgeInsets.only(left: w * 0.02, top: h * 0.005),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                data,
                style: TextStyle(
                    color: ThemeColors.jet,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
