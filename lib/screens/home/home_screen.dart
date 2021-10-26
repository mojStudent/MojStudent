import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/screens/drawer/app_drawer.dart';
import 'package:moj_student/services/home/home_bloc.dart';
import 'package:moj_student/services/home/home_event.dart';
import 'package:moj_student/services/home/home_state.dart';
import 'package:moj_student/services/login/login_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel user;
  AuthRepository _authRepository = new AuthRepository();

  @override
  Widget build(BuildContext context) {
    user = _authRepository.loggedInUser!;

    final bloc = BlocProvider.of<HomeBloc>(context);
    if (bloc.state is InitialState) bloc.add(DataLoaded());

    print("bloc: $bloc");

    return Scaffold(
      appBar: AppBar(
        title: Text("Moj Študent"),
        centerTitle: true,
        backgroundColor: AppColors.success,
        elevation: 0,
      ),
      drawer: AppDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => null,
      //   child: Icon(Icons.menu)
      // ),
      body: BlocProvider(
          create: (context) =>
              HomeBloc(authRepository: context.read<AuthRepository>()),
          child: RefreshIndicator(
            onRefresh: () async {
              bloc.add(RefreshData());
            },
            child: _buildView(context),
          )),
    );
  }


  Widget _buildView(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    print(state);

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
      return CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(top: 0),
          ),
          SliverToBoxAdapter(
            child: _box(
              context,
              _profileCardBody(context),
              "Osnovni podatki",
            ),
          ),
          SliverToBoxAdapter(
            child: _box(
              context,
              Center(
                child: Text("Neprebrana obvestila"),
              ),
              user.notifications.toString(),
            ),
          ),
          SliverToBoxAdapter(
            child: _box(
              context,
              _activeNotificationCardBody(context),
              "Naročila na obvestila",
            ),
          ),
          SliverToBoxAdapter(
            child: _box(
              context,
              _profileDetailedCardBody(context),
              "Napredni podatki profila",
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

  Widget _box(BuildContext context, Widget cardBody, String title,
      {backgroundColor = Colors.white, Icon? icon}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.04,
          horizontal: MediaQuery.of(context).size.height * 0.025),
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          padding: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.025,
            MediaQuery.of(context).size.height * 0.015,
            MediaQuery.of(context).size.width * 0.025,
            MediaQuery.of(context).size.height * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: icon != null
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    icon ?? Container(),
                    Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    )
                  ]),
              Divider(
                thickness: 1,
              ),
              cardBody,
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileCardBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailedRowInBox(user.firstname, "ime"),
        _detailedRowInBox(user.lastname, "priimek"),
        _detailedRowInBox("${user.location} (${user.campus}), ${user.room}",
            "lokacija in številka sobe"),
        _detailedRowInBox(user.email, "e-pošta"),
        _detailedRowInBox(user.username, "uporabniško ime"),
        _detailedRowInBox(user.phone, "telefonska številka"),
        _detailedRowInBox(user.id.toString(), "id uporabnika"),
      ],
    );
  }

  Widget _profileDetailedCardBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailedRowInBox(user.id.toString(), "id uporabnika"),
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
        _detailedRowInBox(
            user.internetAccess ?? false ? 'da' : 'ne', "internetni dostop"),
        _detailedRowInBox(
            user.foreigner ?? false ? 'da' : 'ne', "status tujca"),
        _detailedRowInBox(user.api ?? false ? 'da' : 'ne', "api dostop"),
        _detailedRowInBox(user.emailDate, "datum potrditve e-pošte"),
        _detailedRowInBox(user.ip, "trenutni IP"),
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

    rows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => null,
            child: Wrap(
              children: <Widget>[
                Icon(
                  Icons.edit,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Uredi",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget _detailedRowInBox(String? data, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02, top: 2),
            child: Text(
              data ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
