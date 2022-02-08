import 'package:flutter/material.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/category_name_container.dart';

class CategoryNameSliver extends StatelessWidget {
  const CategoryNameSliver({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CategoryNameContainer(
        categoryName: categoryName,
      ),
    );
  }
}
