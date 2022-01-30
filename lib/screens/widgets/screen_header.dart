import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    Key? key,
    required this.title,
    this.actions = const [],
    this.onBackButtonClick,
    this.backgroundColor
  }) : super(key: key);

  final String title;
  final List<GestureDetector> actions;
  final Function? onBackButtonClick;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(80))),
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      FlutterRemix.arrow_left_s_line,
                      color: Colors.white,
                    ),
                    onTap: () => onBackButtonClick != null
                        ? onBackButtonClick!()
                        : Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      for (var action in actions)
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: action,
                        )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                title.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
