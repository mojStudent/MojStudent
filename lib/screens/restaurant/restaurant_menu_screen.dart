import 'package:flutter/material.dart';
import 'package:moj_student/data/restaurant/restaurant_data_model.dart';
import 'package:moj_student/helpers/compare_dates_only.dart';
import 'package:moj_student/screens/widgets/accordion/accordion.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class RestaurantMenuScreen extends StatelessWidget {
  final List<WeeklyMenu> weeklyMenu;

  const RestaurantMenuScreen({Key? key, required this.weeklyMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        AppHeader(title: "Rožna kuh'na"),
        Expanded(
            child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            for (var day in weeklyMenu)
              SliverToBoxAdapter(
                child: Accordion(
                  expanded: day.date.isSameDate(DateTime.now()),
                  title: day.stringDate,
                  child: Column(children: [
                    for (var menu in day.menus) _menuCard(h, w, menu),
                  ]),
                ),
              ),
          ],
        ))
      ]),
    );
  }

  Widget _menuCard(double h, double w, Menus menu) {
    return RowContainer(
        title: menu.menuName,
        margin: EdgeInsets.symmetric(),
        padding:
            EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.025),
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in menu.menuItems) Text(item),
                ],
              ),
            )
          ],
        ));
  }
}
