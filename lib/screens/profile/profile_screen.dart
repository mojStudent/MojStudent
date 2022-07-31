import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/screens/profile/views/profile_change_email.dart';
import 'package:moj_student/screens/profile/views/profile_change_password.dart';
import 'package:moj_student/screens/profile/views/profile_change_profile.dart';
import 'package:moj_student/screens/widgets/back_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {
    AuthRepository authRepository = AuthRepository();
    user = authRepository.loggedInUser;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: BackNavigationButton(),
          title: Text("Nastavitve profila"),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(indicatorColor: ThemeColors.background, tabs: [
            Tab(
              icon: Icon(
                FlutterRemix.user_3_line,
                color: Colors.white,
              ),
              // text: "Profil",
            ),
            Tab(
              icon: Icon(
                FlutterRemix.lock_2_line,
                color: Colors.white,
              ),
              // text: "Geslo",
            ),
            Tab(
              icon: Icon(
                FlutterRemix.mail_line,
                color: Colors.white,
              ),
              // text: "Email",
            ),
          ]),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            _buildTab(ProfileChangeProfileView()),
            _buildTab(ProfileChangePasswordView()),
            _buildTab(ProfileChangeEmailView()),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(Widget tab) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: tab,
        ),
        SliverPadding(padding: EdgeInsets.only(top: 20)),
      ],
    );
  }
}
