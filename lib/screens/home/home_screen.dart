// ignore_for_file: avoid_unnecessary_containers

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moj_student/animations/page_scale_transition.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/avatars/avatar_repo.dart';
import 'package:moj_student/screens/about_app/about_app_screen.dart';
import 'package:moj_student/screens/damages/damages_screen.dart';
import 'package:moj_student/screens/drawer/app_drawer.dart';
import 'package:moj_student/screens/failures/failures_screen.dart';
import 'package:moj_student/screens/internet/internet_screen.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/notifications/notification_screen.dart';
import 'package:moj_student/screens/profile/profile_screen.dart';
import 'package:moj_student/screens/sports/sports_screen.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/services/blocs/home/home_bloc.dart';
import 'package:moj_student/services/blocs/home/home_event.dart';
import 'package:moj_student/services/blocs/home/home_state.dart';
import 'package:moj_student/services/internet/internet_traffic/internet_traffic_bloc.dart';
import "package:moj_student/helpers/string_extension.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.ghostWhite,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                child: Icon(
                  FlutterRemix.user_3_line,
                  color: AppColors.jet,
                ),
                onTap: () => Navigator.of(context).pushNamed("/profile"),
              ),
              actions: [
                GestureDetector(
                  child: Icon(
                    FlutterRemix.logout_box_r_line,
                    color: AppColors.jet,
                  ),
                  onTap: () {
                    var auth = AuthRepository();
                    auth.logOut().then((value) =>
                        Navigator.of(context).pushReplacementNamed("/login"));
                  },
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: _buildBody(h, w, context, state));
      },
    );
  }

  Widget _buildBody(double h, double w, BuildContext context, HomeState state) {
    if (state is LoadedData) {
      return _buildWithData(h, w, context);
    } else if (state is LoadingData) {
      return LoadingScreen();
    } else if (state is InitialState) {
      context.read<HomeBloc>().add(InitialEvent());
      return LoadingScreen();
    } else if (state is LoadingDataError) {
      return Center(
        child: Text("Prišlo je do napake"),
      );
    } else {
      return Center(
        child: Text("Nekaj se je zgodilo, ne vem točno kaj"),
      );
    }
  }

  Widget _buildWithData(double h, double w, BuildContext context) {
    final state = context.read<HomeBloc>().state as LoadedData;
    final user = state.user;

    return RefreshIndicator(
      onRefresh: () async => context.read<HomeBloc>().add(RefreshData()),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  SvgPicture.network(
                      AvatarRepo.getImgUrlForSeed("${user.username}")),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.firstname} ${user.lastname}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Icon(
                            FlutterRemix.community_line,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${user.campus}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            FlutterRemix.home_2_line,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${user.location}, ${user.room}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _slider(h, w, context),
          _sectionTitle(w, h, title: "bivanje"),

          _iconButton(h, w,
              title: "Obvestila",
              icon: FlutterRemix.notification_3_fill,
              onClick: () => Navigator.pushNamed(context, "/notifications")),
          _iconButton(h, w,
              title: "Internet",
              icon: FlutterRemix.link_m,
              onClick: () => Navigator.pushNamed(context, "/internet")),
          _iconButton(h, w,
              title: "Okvare",
              icon: FlutterRemix.error_warning_fill,
              onClick: () => Navigator.pushNamed(context, "/failures")),
          _iconButton(h, w,
              title: "Škodni zapisniki",
              icon: FlutterRemix.flood_fill,
              onClick: () => Navigator.pushNamed(context, "/damages")),
          //
          _sectionTitle(w, h, title: "storitve"),
          _iconButton(h, w,
              title: "Šport",
              icon: FlutterRemix.ping_pong_fill,
              onClick: () => Navigator.pushNamed(context, "/notifications")),
          _iconButton(h, w,
              title: "Rožna Kuhn'ja",
              icon: FlutterRemix.restaurant_2_fill,
              onClick: () => Navigator.pushNamed(context, "/internet")),
          _sectionTitle(w, h, title: "nastavitve"),
          _iconButton(h, w,
              title: "Nastavitve profila",
              icon: FlutterRemix.user_3_fill,
              onClick: () => Navigator.pushNamed(context, "/profile-settings")),
          _iconButton(h, w,
              title: "O aplikaciji",
              icon: FlutterRemix.app_store_fill,
              onClick: () => Navigator.pushNamed(context, "/about")),
          SliverPadding(padding: EdgeInsets.only(bottom: h * 0.04))
        ],
      ),
    );
  }

  SliverPadding _sectionTitle(double w, double h, {required String title}) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(w * 0.05, h * 0.04, w * 0.05, h * 0.02),
      sliver: SliverToBoxAdapter(
          child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.jet,
        ),
      )),
    );
  }

  SliverToBoxAdapter _iconButton(double h, double w,
      {required String title, required IconData icon, Function? onClick}) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => onClick == null ? () {} : onClick(),
        child: Container(
          width: double.infinity,
          margin:
              EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.005),
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppColors.russianGreen,
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: w * 0.05),
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.75,
                    fontWeight: FontWeight.w700,
                    color: AppColors.jet),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _slider(double h, double w, BuildContext context) {
    final user = (context.read<HomeBloc>().state as LoadedData).user;

    return SliverPadding(
      padding: EdgeInsets.only(top: h * 0.05),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Container(
              height: h * 0.16,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: w * 0.05,
                  ),
                  user.notifications != 0
                      ? _sliderCard(h, w,
                          title: "neprebrana obvestila",
                          dark: true,
                          body: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.notifications}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(FlutterRemix.notification_3_line,
                                  color: Colors.white, size: 18)
                            ],
                          ),
                          onClick: () =>
                              Navigator.pushNamed(context, "/notifications"))
                      : Container(),
                  _sliderCard(
                    h,
                    w,
                    title: "prenos gor",
                    dark: false,
                    onClick: () => Navigator.pushNamed(context, "/internet"),
                    body:
                        BlocBuilder<InternetTrafficBloc, InternetTrafficState>(
                      builder: (context, state) {
                        if (state is InternetTrafficInitial) {
                          context
                              .read<InternetTrafficBloc>()
                              .add(InternetTrafficLoad());
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is InternetTrafficLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is InternetTrafficLoadedState) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.traffic.weeks[0].value.human,
                                    style: TextStyle(
                                        color: AppColors.jet,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "GB",
                                    style: TextStyle(
                                      color: AppColors.jet,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 1,
                              ),
                              CircularProgressIndicator(
                                color: Colors.red,
                                backgroundColor: AppColors.russianGreen,
                                value: state.traffic.weeks[0].progress / 100.0,
                              ),
                            ],
                          );
                        } else if (state is InternetTrafficErrorState) {
                          return Center(child: Text(state.e.toString()));
                        } else {
                          return Center(
                              child: Text("Napak, še sam ne vem zakaj"));
                        }
                      },
                    ),
                  ),
                  BlocBuilder<InternetTrafficBloc, InternetTrafficState>(
                    builder: (context, state) {
                      return _sliderCard(
                        h,
                        w,
                        title: "administrator za internet",
                        dark: false,
                        onClick: (state is! InternetTrafficLoadedState)
                            ? () => null
                            : () => _administratorsBottomSheet(
                                  context,
                                  state,
                                  h,
                                  w,
                                ),
                        body: Builder(builder: (context) {
                          if (state is InternetTrafficInitial) {
                            context
                                .read<InternetTrafficBloc>()
                                .add(InternetTrafficLoad());
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is InternetTrafficLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is InternetTrafficLoadedState) {
                            final administrators = state.administrators;
                            String s = "";
                            for (int i = 0; i < administrators.length; i++) {
                              if (i != 0) {
                                s += "\n";
                              }
                              s += administrators[i].name.capitalize();
                            }

                            return Text(
                              s,
                              style: TextStyle(
                                color: AppColors.jet,
                                fontSize: 18,
                              ),
                            );
                          } else if (state is InternetTrafficErrorState) {
                            return Center(child: Text(state.e.toString()));
                          } else {
                            return Center(
                                child: Text("Napak, še sam ne vem zakaj"));
                          }
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector _sliderCard(
    double h,
    double w, {
    bool dark = false,
    required String title,
    Function? onClick,
    required Widget body,
  }) {
    return GestureDetector(
      onTap: () => onClick == null ? () {} : onClick(),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.02),
        width: w * 0.48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dark ? AppColors.jet : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: dark ? Colors.white : AppColors.jet,
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: dark ? Colors.white : AppColors.jet,
                ),
              ],
            ),
            body
          ],
        ),
      ),
    );
  }

  void _administratorsBottomSheet(BuildContext context,
      InternetTrafficLoadedState state, double h, double w) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.025),
        child: Column(
          children: [
            Text(
              "ADMINISTRATORJI",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
            Divider(
              color: AppColors.ghostWhite,
            ),
            SizedBox(
              height: h * 0.02,
            ),
            for (var administrator in state.administrators)
              Padding(
                padding: EdgeInsets.only(bottom: h * 0.01),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.ghostWhite[600],
                          borderRadius: BorderRadius.circular(10)),
                      child: SvgPicture.network(
                          AvatarRepo.getImgUrlForSeed(administrator.name)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          administrator.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Icon(FlutterRemix.home_2_line,
                                color: Colors.white, size: 18),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Soba ${administrator.room}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      backgroundColor: AppColors.jet,
    );
  }
}
