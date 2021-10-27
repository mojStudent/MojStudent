import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/screens/drawer/app_drawer.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
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
}
