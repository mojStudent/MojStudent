import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/profile/profile_bloc.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return _scaffold(w, h, context);
  }

  Widget _scaffold(double w, double h, BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeColors.background,
          body: Column(
            children: [
              AppHeader(
                title: "PROFIL UPORABNIKA",
                actions: [
                  GestureDetector(
                    child: Icon(
                      FlutterRemix.settings_2_line,
                      color: Colors.white,
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, "/profile-settings"),
                  ),
                ],
              ),
              if (state is ProfileInitial)
                _loadingProfile(context, true)
              else if (state is ProfileLoadingState)
                _loadingProfile(context, false)
              else if (state is ProfileLoadedState)
                _profileLoaded(w, h, state.user)
            ],
          ),
        );
      },
    );
  }

  Widget _loadingProfile(BuildContext context, bool emitEvent) {
    context.read<ProfileBloc>().add(LoadProfile());
    return Text("Nalaganje");
  }

  Expanded _profileLoaded(double w, double h, UserModel user) {
    return Expanded(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CategoryNameSliver(categoryName: "Osnovni podatki"),
          TextRowSliver(
              title: "ime in priimek",
              data: "${user.firstname} ${user.lastname}",
              icon: FlutterRemix.user_smile_line),
          TextRowSliver(
              title: "lokacija in številka sobe",
              data: "${user.location} (${user.campus}), ${user.room}",
              icon: FlutterRemix.home_2_line),
          TextRowSliver(
              title: "uporabniško ime",
              data: "${user.username}",
              icon: FlutterRemix.user_3_line),
          TextRowSliver(
              title: "status tujca",
              data: (user.foreigner ?? false) ? 'da' : 'ne',
              icon: FlutterRemix.earth_line),
          TextRowSliver(
              title: "številka uporabnika",
              data: "${user.id}",
              icon: FlutterRemix.passport_line),
          //
          CategoryNameSliver(categoryName: "Kontaktni podatki"),
          TextRowSliver(
              title: "e-pošta",
              data: "${user.email}",
              icon: FlutterRemix.mail_line),
          TextRowSliver(
              title: "datum potrditve e-pošte",
              data: "${user.emailDate}",
              icon: FlutterRemix.calendar_2_line),
          TextRowSliver(
              title: "telefonska številka",
              data: "${user.phone}",
              icon: FlutterRemix.phone_line),
          //
          CategoryNameSliver(categoryName: "Napredni podatki profila"),
          TextRowSliver(
              title: "api dostop",
              data: (user.api ?? false) ? 'da' : "ne",
              icon: FlutterRemix.database_2_line),
          TextRowSliver(
              title: "internetni dostop",
              data: (user.internetAccess ?? false) ? 'da' : "ne",
              icon: FlutterRemix.cloud_line),
          TextRowSliver(
              title: "tip uporabniškega računa",
              data: user.rolesToString(),
              icon: FlutterRemix.shield_user_line),
          TextRowSliver(
              title: "trenutni ip",
              data: "${user.ip}",
              icon: FlutterRemix.link_m),
          SliverPadding(padding: EdgeInsets.only(bottom: h * 0.04))
        ],
      ),
    );
  }
}

