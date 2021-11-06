import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';

class BoxWidget extends StatelessWidget {
  final Widget cardBody;
  final String title;
  final Color backgroundColor;
  final Icon? icon;

  const BoxWidget(
      {Key? key,
      required this.cardBody,
      required this.title,
      this.backgroundColor = Colors.white,
      this.icon,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.04,
          horizontal: MediaQuery.of(context).size.height * 0.025),
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.raisinBlack[100]!,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(8, 6), // changes position of shadow
                ),
              ]),
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.025,
            MediaQuery.of(context).size.height * 0.015,
            MediaQuery.of(context).size.width * 0.025,
            MediaQuery.of(context).size.height * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: icon != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    icon ?? Container(),
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                    )
                  ]),
              Divider(
                thickness: 1,
              ),
              cardBody,
            ],
          ),
        ),
      ),
    );
  }
}

class RowBoxWidget extends StatelessWidget {
  final String description;
  final String? data;

  const RowBoxWidget({Key? key, required this.description, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02, top: 2),
            child: Text(
              data ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
