// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/avatars/avatar_repo.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/services/blocs/home/home_bloc.dart';
import 'package:moj_student/services/blocs/home/home_event.dart';
import 'package:moj_student/services/blocs/home/home_state.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel user;
  final AuthRepository _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    user = _authRepository.loggedInUser!;

    final bloc = BlocProvider.of<HomeBloc>(context);
    if (bloc.state is InitialState) bloc.add(DataLoaded());

    return Scaffold(
      backgroundColor: AppColors.green,
      body: BlocProvider(
          create: (context) =>
              HomeBloc(authRepository: context.read<AuthRepository>()),
          child: RefreshIndicator(
            onRefresh: () async {
              bloc.add(RefreshData());
            },
            child: SafeArea(child: _buildView(context)),
          )),
    );
  }

  Widget _buildView(BuildContext context) {
    final state = context.watch<HomeBloc>().state;

    if (state is LoadingData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is LoadingDataError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.yellow,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Text(
              "Napaka pri pridobivanju podatkov",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            TextButton(
                onPressed: () => context.read<HomeBloc>().add(RefreshData()),
                child: Text("Poskusi ponovno"))
          ],
        ),
      );
    } else if (state is LoadedData) {
      if (state.showTab == LoadedDataTab.MENU) {
        return CustomScrollView(
          slivers: [
            _header(),
            _menu(context),
          ],
        );
      }
      return CustomScrollView(
        slivers: <Widget>[
          _header(),
          SliverToBoxAdapter(
            child: BoxWidget(
              cardBody: _profileCardBody(context),
              title: "Osnovni podatki",
            ),
          ),
          SliverToBoxAdapter(
            child: BoxWidget(
              cardBody: Center(
                child: Text("Neprebrana obvestila"),
              ),
              title: user.notifications.toString(),
            ),
          ),
          SliverToBoxAdapter(
            child: BoxWidget(
              cardBody: _activeNotificationCardBody(context),
              title: "Naročila na obvestila",
            ),
          ),
          SliverToBoxAdapter(
            child: BoxWidget(
              cardBody: _profileDetailedCardBody(context),
              title: "Napredni podatki profila",
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 50),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _profileCardBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowBoxWidget(
          data: user.firstname,
          description: "ime",
        ),
        RowBoxWidget(
          data: user.lastname,
          description: "priimek",
        ),
        RowBoxWidget(
          data: "${user.location} (${user.campus}), ${user.room}",
          description: "lokacija in številka sobe",
        ),
        RowBoxWidget(
          data: user.email,
          description: "e-pošta",
        ),
        RowBoxWidget(
          data: user.username,
          description: "uporabniško ime",
        ),
        RowBoxWidget(
          data: user.phone,
          description: "telefonska številka",
        ),
        RowBoxWidget(
          data: user.id.toString(),
          description: "id uporabnika",
        ),
      ],
    );
  }

  Widget _profileDetailedCardBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RowBoxWidget(data: user.id.toString(), description: "id uporabnika"),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "tipi uporabniškega računa",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02, top: 2),
                  child: Column(
                    children: [
                      for (var role in user.roles)
                        Text(
                          role.name ?? '',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                    ],
                  )),
            ],
          ),
        ),
        RowBoxWidget(
          data: user.internetAccess ?? false ? 'da' : 'ne',
          description: "internetni dostop",
        ),
        RowBoxWidget(
          data: user.foreigner ?? false ? 'da' : 'ne',
          description: "status tujca",
        ),
        RowBoxWidget(
          data: user.api ?? false ? 'da' : 'ne',
          description: "api dostop",
        ),
        RowBoxWidget(
          data: user.emailDate,
          description: "datum potrditve e-pošte",
        ),
        RowBoxWidget(
          data: user.ip,
          description: "trenutni IP",
        ),
      ],
    );
  }

  Widget _activeNotificationCardBody(BuildContext context) {
    List<Widget> rows = [];
    for (var s in user.subscriptions) {
      rows.add(Row(
        children: [
          Icon(
            s.selected ?? false
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank,
            color: s.locked ?? false ? Colors.black38 : Colors.black,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Flexible(child: Text(s.name ?? '')),
        ],
      ));
      rows.add(SizedBox(
        height: 3,
      ));
    }

    // rows.add(
    //   Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       TextButton(
    //         onPressed: () {},
    //         child: Wrap(
    //           children: <Widget>[
    //             Icon(
    //               Icons.edit,
    //               size: 16,
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             Text(
    //               "Uredi",
    //               style: TextStyle(fontSize: 14),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _header() {
    final state = (context.read<HomeBloc>().state as LoadedData);

    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: AppColors.raisinBlack.withOpacity(0.5),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(11)),
                      child: IconButton(
                        icon: Icon(
                          state.showTab == LoadedDataTab.MENU
                              ? Icons.person
                              : Icons.apps,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          context.read<HomeBloc>().add(ChangeTabEvent(
                                state,
                                (state.showTab == LoadedDataTab.MENU
                                    ? LoadedDataTab.PROFILE
                                    : LoadedDataTab.MENU),
                              ));
                        },
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(11)),
                      child: IconButton(
                        icon: Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          var auth = AuthRepository();
                          auth.logOut().then((value) => Navigator.of(context)
                              .pushReplacementNamed("/login"));
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SvgPicture.network(AvatarRepo.getImgUrlForSeed(
                          "${user.firstname}-${user.lastname}")),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "${user.firstname} ${user.lastname}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${user.location} (${user.campus}), ${user.room}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menu(BuildContext context) {
    final menuItems = [
      _menuItem(
          title: "Internetni dostop",
          icon: Icons.wifi,
          onPressed: () => Navigator.of(context).pushNamed("/internet")),
      _menuItem(
          title: "Obvestila (${user.notifications} neprebranih)",
          icon: Icons.notifications_none_outlined,
          onPressed: () => Navigator.of(context).pushNamed("/notifications")),
      _menuItem(
          title: "Okvare",
          icon: Icons.error_outline,
          onPressed: () => Navigator.of(context).pushNamed("/failures")),
      _menuItem(
          title: "Škodni zapisniki",
          icon: Icons.houseboat_outlined,
          onPressed: () => Navigator.of(context).pushNamed("/damages")),
      _menuItem(
          title: "Nastavitve profila",
          icon: Icons.settings_outlined,
          onPressed: () => Navigator.of(context).pushNamed("/profile")),
    ];

    return SliverToBoxAdapter(
      child: BoxWidget(
          cardBody: Container(
            child: Column(
              children: menuItems,
            ),
          ),
          title: "Storitve"),
    );
  }

  Widget _menuItem(
      {required String title,
      required IconData icon,
      required Function onPressed}) {
    return TextButton(
        onPressed: () => onPressed(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
            )
          ],
        ));
  }
}
