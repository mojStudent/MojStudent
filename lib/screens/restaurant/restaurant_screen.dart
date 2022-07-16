import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/restaurant/restaurant_data_model.dart';
import 'package:moj_student/data/restaurant/restaurant_repo.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/restaurant/restaurant_menu_screen.dart';
import 'package:moj_student/screens/widgets/accordion/accordion.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/menu_iconbutton_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/row_button_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/save_button_widget.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/screens/widgets/vertical_slider/vertical_slider.dart';
import 'package:moj_student/screens/widgets/vertical_slider/vertical_slider_card.dart';
import 'package:moj_student/services/blocs/restaurant/restaurant_cubit.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(children: [
        AppHeader(title: "Rožna kuh'na"),
        RepositoryProvider(
          create: (context) => RestaurantRepo(),
          child: BlocProvider(
            create: (context) =>
                RestaurantCubit(context.read<RestaurantRepo>()),
            child:
                Expanded(child: BlocBuilder<RestaurantCubit, RestaurantState>(
              builder: (context, state) {
                if (state is RestaurantLoadingState) {
                  return LoadingScreen(
                    withScaffold: false,
                  );
                } else if (state is RestaurantErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is RestaurantLoadedState) {
                  return _buildWithData(h, w, context);
                }
                return Center(
                  child: Text("Napaka, še sam ne vem kakšna"),
                );
              },
            )),
          ),
        )
      ]),
    );
  }

  CustomScrollView _buildWithData(double h, double w, BuildContext context) {
    final state =
        context.read<RestaurantCubit>().state as RestaurantLoadedState;

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        CategoryNameSliver(categoryName: "Delovni čas restavracije"),
        _slider(
          h,
          state.data.timetableModel.restaurant
              .map((e) => VerticalSLiderCard(
                  title: e.hours, body: Text(e.days.replaceAll(":", ""))))
              .toList(),
        ),
        CategoryNameSliver(categoryName: "Delovni čas bara"),
        _slider(
          h,
          state.data.timetableModel.bar
              .map((e) => VerticalSLiderCard(
                  title: e.hours, body: Text(e.days.replaceAll(":", ""))))
              .toList(),
        ),
        for (Widget w in _todaysMenu(state.data.getTodaysMenu(), h, w)) w,
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: h * 0.01, right: w * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantMenuScreen(
                        weeklyMenu: state.data.weeklyMenu,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text("Tedenski menu"),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        FlutterRemix.arrow_right_s_line,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: SizedBox(
          height: h * 0.05,
        ))
      ],
    );
  }

  Widget _menuCard(double h, double w, Menus menu) {
    return RowSliver(
        title: menu.menuName,
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

  Widget _slider(final h, List<VerticalSLiderCard> cards) {
    return VerticalSlider(height: h * 0.1 >= 100 ? h * 0.1 : 100, cards: cards);
  }

  List<Widget> _todaysMenu(
    WeeklyMenu? todaysMenu,
    double h,
    double w,
  ) {
    final header = CategoryNameSliver(categoryName: "Današnji jedilnik");
    return todaysMenu == null
        ? [
            header,
            RowSliver(child: Text("Ni objavljenih jedilnikov")),
          ]
        : [
            header,
            for (var menu in todaysMenu.menus) _menuCard(h, w, menu),
          ];
  }
}
