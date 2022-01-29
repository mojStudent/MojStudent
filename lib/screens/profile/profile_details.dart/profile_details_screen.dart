import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/services/blocs/home/home_state.dart';
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
          backgroundColor: AppColors.ghostWhite,
          body: Column(
            children: [
              _header(w, h, context),
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
          _categoryName(w, h, categoryName: "Osnovni podatki"),
          _dataRow(w, h,
              dataName: "ime in priimek",
              data: "${user.firstname} ${user.lastname}",
              icon: FlutterRemix.user_smile_line),
          _dataRow(w, h,
              dataName: "lokacija in številka sobe",
              data: "${user.location} (${user.campus}), ${user.room}",
              icon: FlutterRemix.home_2_line),
          _dataRow(w, h,
              dataName: "uporabniško ime",
              data: "${user.username}",
              icon: FlutterRemix.user_3_line),
          _dataRow(w, h,
              dataName: "status tujca",
              data: (user.foreigner ?? false) ? 'da' : 'ne',
              icon: FlutterRemix.earth_line),
          _dataRow(w, h,
              dataName: "številka uporabnika",
              data: "${user.id}",
              icon: FlutterRemix.passport_line),
          //
          _categoryName(w, h, categoryName: "Kontaktni podatki"),
          _dataRow(w, h,
              dataName: "e-pošta",
              data: "${user.email}",
              icon: FlutterRemix.mail_line),
          _dataRow(w, h,
              dataName: "datum potrditve e-pošte",
              data: "${user.emailDate}",
              icon: FlutterRemix.calendar_2_line),
          _dataRow(w, h,
              dataName: "telefonska številka",
              data: "${user.phone}",
              icon: FlutterRemix.phone_line),
          //
          _categoryName(w, h, categoryName: "Napredni podatki profila"),
          _dataRow(w, h,
              dataName: "api dostop",
              data: (user.api ?? false) ? 'da' : "ne",
              icon: FlutterRemix.database_2_line),
          _dataRow(w, h,
              dataName: "internetni dostop",
              data: (user.internetAccess ?? false) ? 'da' : "ne",
              icon: FlutterRemix.cloud_line),
          _dataRow(w, h,
              dataName: "tip uporabniškega računa",
              data: user.rolesToString(),
              icon: FlutterRemix.shield_user_line),
          _dataRow(w, h,
              dataName: "trenutni ip",
              data: "${user.ip}",
              icon: FlutterRemix.link_m),
          SliverPadding(padding: EdgeInsets.only(bottom: h * 0.04))
        ],
      ),
    );
  }

  Container _header(double w, double h, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: AppColors.jet,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      FlutterRemix.arrow_left_s_line,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  GestureDetector(
                    child: Icon(
                      FlutterRemix.settings_2_line,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.pushNamed(context, "/profile-settings"),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                "PROFIL UPORABNIKA",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ))
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _categoryName(double w, double h,
      {required String categoryName}) {
    return SliverPadding(
        padding: EdgeInsets.fromLTRB(
          w * 0.04,
          h * 0.03,
          w * 0.04,
          h * 0.015,
        ),
        sliver: SliverToBoxAdapter(
          child: Text(
            categoryName,
            style: TextStyle(
                fontSize: 18,
                color: AppColors.jet,
                fontWeight: FontWeight.w700),
          ),
        ));
  }

  SliverToBoxAdapter _dataRow(double w, double h,
      {required String dataName,
      required IconData icon,
      required String data}) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
        margin:
            EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.0075),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: w * 0.025,
                  child: Divider(thickness: 1.5, color: AppColors.jet[300]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                  child: Text(
                    dataName.toUpperCase(),
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.jet),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: w * 0.01),
                  child: Icon(
                    icon,
                    size: 15,
                  ),
                ),
                Expanded(
                    child: Divider(
                  thickness: 1.5,
                  color: AppColors.jet[300],
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.02, top: h * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      data,
                      style: TextStyle(
                          color: AppColors.jet,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
