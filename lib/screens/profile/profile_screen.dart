import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/screens/profile/views/profile_change_email.dart';
import 'package:moj_student/screens/profile/views/profile_change_password.dart';
import 'package:moj_student/screens/profile/views/profile_change_profile.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Nastavitve profila"),
        backgroundColor: AppColors.raisinBlack[500],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppColors.green,
      body: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.only(top: 20)),
          SliverToBoxAdapter(child: ProfileChangeProfileView()),
          SliverToBoxAdapter(child: ProfileChangePasswordView()),
          SliverToBoxAdapter(child: ProfileChangeEmailView()),
          SliverPadding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }
}
