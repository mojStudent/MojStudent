import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/avatars/avatar_repo.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/profile/profile_bloc.dart';

class ProfilePanelView extends StatelessWidget {
  const ProfilePanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return _scaffold(w, h, context);
  }

  Widget _scaffold(double w, double h, BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Stack(
          children: [
            if (state is ProfileInitial)
              _loadingProfile(context, true)
            else if (state is ProfileLoadingState)
              _loadingProfile(context, false)
            else if (state is ProfileLoadedState)
              _profileLoaded(w, h, state.user),
            _header(h, context, w, state),
          ],
        );
      },
    );
  }

  Stack _header(double h, BuildContext context, double w, ProfileState state) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: h * 0.17,
          decoration: BoxDecoration(
            color: ThemeColors.primary,
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
                          FlutterRemix.settings_2_line,
                          color: Colors.white,
                        ),
                        onTap: () =>
                            Navigator.pushNamed(context, "/profile-settings"),
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
                  child: state is ProfileLoadedState
                      ? _userCard(w, state.user)
                      : Container()),
            ),
          ),
        )
      ],
    );
  }

  Widget _loadingProfile(BuildContext context, bool emitEvent) {
    context.read<ProfileBloc>().add(LoadProfile());
    return Text("Nalaganje");
  }

  Widget _profileLoaded(double w, double h, UserModel user) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: h * 0.2),
          sliver: SliverToBoxAdapter(child: Container()),
        ),
        CategoryNameSliver(categoryName: "Osnovni podatki"),
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
        SliverPadding(padding: EdgeInsets.only(bottom: h * 0.1))
      ],
    );
  }

  Widget _userCard(double w, UserModel user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.network(AvatarRepo.getImgUrlForSeed("${user.username}")),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.firstname} ${user.lastname}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Row(
              children: [
                Icon(
                  FlutterRemix.community_line,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${user.campus}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  FlutterRemix.home_2_line,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${user.location}, ${user.room}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
