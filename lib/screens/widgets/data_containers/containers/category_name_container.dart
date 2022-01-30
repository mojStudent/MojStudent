import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';

class CategoryNameContainer extends StatelessWidget {
  const CategoryNameContainer({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        w * 0.04,
        h * 0.03,
        w * 0.04,
        h * 0.015,
      ),
      child: Text(
        categoryName,
        style: TextStyle(
            fontSize: 18, color: AppColors.jet, fontWeight: FontWeight.w700),
      ),
    );
  }
}
