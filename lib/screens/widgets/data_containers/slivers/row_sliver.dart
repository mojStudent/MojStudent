import 'package:flutter/material.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';

class RowSliver extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Widget child;
  final Function? onClick;

  const RowSliver(
      {Key? key, required this.child, this.title, this.icon, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => onClick == null ? null : onClick!(),
        child: RowContainer(
          title: title,
          icon: icon,
          child: child,
        ),
      ),
    );
  }
}
