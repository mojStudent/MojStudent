import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/avatars/avatar_repo.dart';
import "package:moj_student/helpers/string_extension.dart";
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/menu_iconbutton_sliver.dart';
import 'package:moj_student/services/blocs/home/home_bloc.dart';
import 'package:moj_student/services/blocs/home/home_event.dart';
import 'package:moj_student/services/blocs/home/home_state.dart';
import 'package:moj_student/services/internet/internet_traffic/internet_traffic_bloc.dart';

class HomePanelView extends StatelessWidget {
  const HomePanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(child: _buildBody(h, w, context, state)),
              ],
            ),
            _header(h, context, w),
          ],
        );
      },
    );
  }

  Stack _header(double h, BuildContext context, double w) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: h * 0.17,
          decoration: BoxDecoration(
            color: ThemeColors.primary,
            // borderRadius:
            //     BorderRadius.only(bottomRight: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      GestureDetector(
                        child: Icon(
                          FlutterRemix.logout_box_r_line,
                          color: Colors.white,
                        ),
                        onTap: () {
                          var auth = AuthRepository();
                          auth.logOut().then((value) => Navigator.of(context)
                              .pushReplacementNamed("/login"));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: h * 0.08),
          child: Padding(
            padding: EdgeInsets.only(right: w * 0.15),
            child: Container(
              height: h * 0.12,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: ThemeColors.jet.withOpacity(0.25),
                        offset: Offset(0, 5),
                        blurRadius: 10)
                  ],
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.only(left: w * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MojŠtudent",
                      style: TextStyle(
                          color: ThemeColors.jet,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Študentski dom Ljubljana",
                      style: TextStyle(
                          color: ThemeColors.jet,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
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
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(RefreshData());
        context.read<InternetTrafficBloc>().add(InternetTrafficLoad());
      },
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: h * 0.2),
            sliver: SliverToBoxAdapter(child: Container()),
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
              title: "Prenočevalci",
              icon: FlutterRemix.hotel_bed_fill,
              onClick: () => Navigator.pushNamed(context, "/overnight")),
          _iconButton(h, w,
              title: "Škodni zapisniki",
              icon: FlutterRemix.flood_fill,
              onClick: () => Navigator.pushNamed(context, "/damages")),
          _iconButton(h, w,
              title: "Dežurna knjiga",
              icon: FlutterRemix.police_car_fill,
              onClick: () => Navigator.pushNamed(context, "/logbook")),

          _sectionTitle(w, h, title: "storitve"),
          _iconButton(h, w,
              title: "Rožna kuh'nja",
              icon: FlutterRemix.restaurant_fill,
              onClick: () => Navigator.pushNamed(context, "/restaurant")),

          _iconButton(h, w,
              title: "Šport",
              icon: FlutterRemix.ping_pong_fill,
              onClick: () => Navigator.pushNamed(context, "/sports")),
          // _iconButton(h, w,
          //     title: "Rožna Kuhn'ja",
          //     icon: FlutterRemix.restaurant_2_fill,
          //     onClick: () => Navigator.pushNamed(context, "/internet")),
          _sectionTitle(w, h, title: "nastavitve"),
          _iconButton(h, w,
              title: "Nastavitve profila",
              icon: FlutterRemix.user_3_fill,
              onClick: () => Navigator.pushNamed(context, "/profile-settings")),
          _iconButton(h, w,
              title: "O aplikaciji",
              icon: FlutterRemix.app_store_fill,
              onClick: () => Navigator.pushNamed(context, "/about")),
          SliverPadding(padding: EdgeInsets.only(bottom: h * 0.04)),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  horizontal: w * 0.06, vertical: h * 0.005),
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.03, vertical: h * 0.01),
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "${DateTime.now().year} MarelaTeam",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Vse pravice pridržane",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: h * 0.1))
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
          color: ThemeColors.jet,
        ),
      )),
    );
  }

  MenuIconButtonSliver _iconButton(double h, double w,
      {required String title,
      required IconData icon,
      Function? onClick,
      bool? darkTheme}) {
    return MenuIconButtonSliver(
      title: title,
      icon: icon,
      onClick: onClick,
      darkTheme: darkTheme ?? false,
    );
  }

  Widget _slider(double h, double w, BuildContext context) {
    final user = (context.read<HomeBloc>().state as LoadedData).user;

    return SliverPadding(
      padding: EdgeInsets.only(top: h * 0.025),
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
                                    state.traffic.weeks[0].value.human
                                        .split(" GB")[0],
                                    style: TextStyle(
                                        color: ThemeColors.jet,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "GB",
                                    style: TextStyle(
                                      color: ThemeColors.jet,
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
                                backgroundColor: ThemeColors.primary,
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
                                color: ThemeColors.jet,
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
          color: dark ? ThemeColors.primary : Colors.white,
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
                    color: dark ? Colors.white : ThemeColors.jet,
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: dark ? Colors.white : ThemeColors.jet,
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
              color: ThemeColors.background,
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
                          color: ThemeColors.background[600],
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
      backgroundColor: ThemeColors.jet,
    );
  }
}
