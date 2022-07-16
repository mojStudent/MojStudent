import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';

class VerticalSLiderCard extends StatelessWidget {
  final String title;
  final Function? onClick;
  final bool dark;
  final Widget body;
  final double? width;

  const VerticalSLiderCard(
      {Key? key,
      required this.title,
      required this.body,
      this.onClick,
      this.dark = false,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    double width = w * 0.48 <= 200 ? w * 0.48 : 200;

    return GestureDetector(
      onTap: () => onClick == null ? () {} : onClick!(),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.02),
        width: this.width ?? width,
        height: 1000,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dark ? ThemeColors.primary : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: dark ? Colors.white : ThemeColors.jet,
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: dark ? Colors.white : ThemeColors.jet,
                ),
              ],
            ),
            body
          ],
        ),
      ),
    );
  }
}
