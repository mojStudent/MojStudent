import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/auth/models/profile/change_email_model.dart';
import 'package:moj_student/data/auth/profile_repository.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/profile/profile_change_email.dart';
import 'package:moj_student/screens/profile/profile_change_password.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/modal.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileForm = GlobalKey<FormState>();

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
          SliverToBoxAdapter(child: _profileChangeForm()),
          SliverToBoxAdapter(child: ProfileChangePasswordView()),
          SliverToBoxAdapter(child: ProfileChangeEmailView()),
          SliverPadding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }

  ElevatedButton _saveButton(
    String text,
    IconData icon, {
    Function? onClick,
    disabled = false,
  }) {
    return ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(text),
          ],
        ),
        style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 35)),
        onPressed: disabled && onClick != null ? null : (() => onClick!()));
  }

  Widget _profileChangeForm() {
    return BoxWidget(
      title: "Sprememba nastavitev profila",
      cardBody: Form(
        key: _profileForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(label: Text("Telefonska številka")),
              validator: (value) => null,
              onChanged: (value) => null,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Text("Prijava na obvestila"),
            CheckboxListTile(
              title: Text("Sistemska obvestila"),
              value: true,
              onChanged: (value) => null,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            _saveButton("Posodobi geslo", Icons.save),
          ],
        ),
      ),
    );
  }
}
