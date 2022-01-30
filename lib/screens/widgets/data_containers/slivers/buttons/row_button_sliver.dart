import 'package:flutter/material.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/buttons/row_button.dart';

class RowButtonSliver extends StatelessWidget {
  final IconData? icon;
  final String title;
  final Function onPressed;

  const RowButtonSliver(
      {Key? key, this.icon, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RowButton(
        title: title,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
