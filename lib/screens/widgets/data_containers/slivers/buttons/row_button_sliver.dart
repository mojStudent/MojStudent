import 'package:flutter/material.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/buttons/row_button.dart';

class RowButtonSliver extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function onPressed;
  final ButtonStyle? style;

  const RowButtonSliver({
    Key? key,
    this.icon,
    required this.title,
    required this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RowButton(
        title: title,
        icon: icon,
        style: style,
        onPressed: onPressed,
      ),
    );
  }
}
