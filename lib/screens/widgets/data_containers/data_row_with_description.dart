import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';

class DataRowWidget extends StatelessWidget {
  final String dataName;
  final IconData? icon;
  final String data;

  const DataRowWidget(
      {Key? key, required this.data, required this.dataName, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
        margin:
            EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.0075),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: w * 0.025,
                  child: Divider(thickness: 1.5, color: AppColors.jet[300]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                  child: Text(
                    dataName.toUpperCase(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.jet),
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
                  color: AppColors.jet[300],
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.02, top: h * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      data,
                      style: TextStyle(
                          color: AppColors.jet,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
