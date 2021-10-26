import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/screens/home/home_screen.dart';
import 'package:moj_student/screens/login/login_screen.dart';
import 'package:moj_student/screens/notifications/notification_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          _drawerItem("Začetna stran", Icons.home_outlined,
              onClick: () =>
                  Navigator.of(context).pushReplacementNamed("/home")),
          _drawerItem(
              "Internetni dostop", Icons.swap_horizontal_circle_outlined,
              onClick: () =>
                  Navigator.of(context).pushReplacementNamed("/internet")),
          _drawerItem("Obvestila", Icons.notifications_none_outlined,
              onClick: () =>
                  Navigator.pushReplacementNamed(context, "/notifications")),
          _drawerItem("Okvare", Icons.error_outline,
              onClick: () =>
                  Navigator.of(context).pushReplacementNamed('/failures')),
          _drawerItem("Škodni zapisniki", Icons.houseboat_outlined,
              onClick: () =>
                  Navigator.of(context).pushReplacementNamed("/damages")),
          _drawerItem(
            "Profil",
            Icons.person_outline,
          ),
          _drawerItem("Odjava", Icons.exit_to_app_outlined, onClick: () {
            var auth = AuthRepository();
            auth.logOut().then((value) =>
                Navigator.of(context).pushReplacementNamed("/login"));
          }
              // (Route<dynamic> route) => false),
              ),
        ],
      ),
    );
  }

  DrawerHeader _drawerHeader() {
    return DrawerHeader(
        decoration: BoxDecoration(
          color: AppColors.success,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Moj Študent",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "by MarelaTeam",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ));
  }

  ListTile _drawerItem(String name, IconData icon, {void onClick()?}) {
    return ListTile(
      onTap: onClick,
      title: Row(
        children: [
          Icon(icon, color: Colors.black45),
          SizedBox(
            width: 5,
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
