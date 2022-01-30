import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';

class RowSliver extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget child;

  const RowSliver(
      {Key? key, required this.child, required this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: RowContainer(
        title: title,
        child: child,
      ),
    );
  }
}
