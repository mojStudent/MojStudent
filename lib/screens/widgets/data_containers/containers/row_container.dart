import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';

class RowContainer extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget child;

  const RowContainer({Key? key, required this.child, this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
      margin: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.0075),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          title != null
              ? Row(
                  children: [
                    Container(
                      width: w * 0.025,
                      child:
                          Divider(thickness: 1.5, color: ThemeColors.jet[300]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                      child: Text(
                        title!.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.jet),
                      ),
                    ),
                    icon == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(right: w * 0.01),
                            child: Icon(
                              icon,
                              size: 15,
                            ),
                          ),
                    Expanded(
                        child: Divider(
                      thickness: 1.5,
                      color: ThemeColors.jet[300],
                    )),
                  ],
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(left: w * 0.02, top: h * 0.005),
            child: child,
          )
        ],
      ),
    );
  }
}
