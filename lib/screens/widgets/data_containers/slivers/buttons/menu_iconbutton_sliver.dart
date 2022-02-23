import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';

class MenuIconButtonSliver extends StatelessWidget {
  final Function? onClick;
  final String title;
  final IconData icon;

  const MenuIconButtonSliver({
    Key? key,
    this.onClick,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => onClick == null ? () {} : onClick!(),
        child: Container(
          width: double.infinity,
          margin:
              EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.005),
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: ThemeColors.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: w * 0.05),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.75,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.jet),
              )
            ],
          ),
        ),
      ),
    );
  }
}
