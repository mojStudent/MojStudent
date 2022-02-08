import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/sports/models/sport_subcribtion_model.dart';
import 'package:moj_student/helpers/base64_converter.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/sports/widgets/sport_subscription_widget.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/home/home_state.dart';
import 'package:moj_student/services/blocs/sports/sport_bloc.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      children: [
        AppHeader(title: "Šport"),
        Expanded(
          child: BlocBuilder<SportBloc, SportState>(
            builder: (context, state) {
              if (state is SportInitial) {
                context.read<SportBloc>().add(SportLoadEvent());
                return LoadingScreen(
                  withScaffold: false,
                );
              } else if (state is SportLoadingState) {
                return LoadingScreen(
                  withScaffold: false,
                );
              } else if (state is SportLoadedState) {
                return CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    state.fitnesCard != null
                        ? _fitnessCard(state, w)
                        : SliverToBoxAdapter(),
                    CategoryNameSliver(categoryName: "Moje naročnine"),
                    for (var w in _buildActiveSubscriptionList(
                        context, state.subscriptions))
                      w,
                    SliverPadding(
                      padding: EdgeInsets.only(top: h * 0.02),
                      sliver: SliverToBoxAdapter(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed("/sports/subscriptions"),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Poglej vse".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: ThemeColors.jet),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(FlutterRemix.arrow_right_line,
                                  size: 18, color: ThemeColors.jet),
                              SizedBox(
                                width: w * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is SportErrorState) {
                return RefreshIndicator(
                    onRefresh: () async =>
                        context.read<SportBloc>().add(SportLoadEvent()),
                    child: Text("Napaka"));
              } else {
                return RefreshIndicator(
                    onRefresh: () async =>
                        context.read<SportBloc>().add(SportLoadEvent()),
                    child: Text("Napaka, ne vem kaka"));
              }
            },
          ),
        ),
      ],
    ));
  }

  RowSliver _fitnessCard(SportLoadedState state, double w) {
    return RowSliver(
      title: "Moja fitnes kartica",
      icon: FlutterRemix.boxing_line,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FlutterRemix.edit_line,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ustvarjeno",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            (state.fitnesCard?.created ?? ''),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      FlutterRemix.save_3_line,
                      size: 16,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Posodobljeno",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                          Text(
                            (state.fitnesCard?.updated ?? ''),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: w * 0.25,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Base64Converter.imageFromBase64String(
                state.fitnesCard?.imageSrc ?? ""),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActiveSubscriptionList(
      BuildContext context, List<SportSubscriptionModel> subscriptions) {
    List<Widget> list = [];

    if (subscriptions.any((e) => e.subscribed)) {
      for (var subscription in subscriptions.where((e) => e.subscribed)) {
        list.add(
          SportSubscriptionWidget(
            subscription: subscription,
            onTap: () {
              context.read<SportBloc>().add(
                    SportLoadSubscriptionDetailEvent(
                      context.read<SportBloc>().state as SportLoadedState,
                      subscription,
                    ),
                  );
              Navigator.of(context).pushNamed("/sports/subscription-details");
            },
          ),
        );
      }
    } else {
      list.add(RowSliver(
          child: Center(
        child: Text(
          "Trenutno nimate aktivnih naročnin",
          style: TextStyle(fontSize: 16),
        ),
      )));
    }

    return list;
  }
}
