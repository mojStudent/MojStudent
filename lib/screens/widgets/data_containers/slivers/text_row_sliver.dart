import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/text_row_container.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';

class TextRowSliver extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String data;

  const TextRowSliver(
      {Key? key, required this.data, required this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: TextRowContainer(
        data: data,
        title: title,
      ),
    );
  }
}
