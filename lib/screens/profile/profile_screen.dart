import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _passwordForm = GlobalKey<FormState>();
  final _mailForm = GlobalKey<FormState>();
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
          SliverToBoxAdapter(
            child: BoxWidget(
              title: "Sprememba nastavitev profila",
              cardBody: Container(),
            ),
          ),
          SliverToBoxAdapter(
            child: BoxWidget(
              title: "Sprememba gesla",
              cardBody: Form(
                key: _passwordForm,
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Novo geslo"),
                      validator: (value) => null,
                      onChanged: (value) => null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: "Ponovi geslo"),
                      validator: (value) => null,
                      onChanged: (value) => null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _saveButton("Posodobi geslo", Icons.save),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BoxWidget(
              title: "Sprememba e-naslova",
              cardBody: Form(
                key: _mailForm,
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(hintText: "Nov e-naslov"),
                      validator: (value) => null,
                      onChanged: (value) => null,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    _saveButton("Posodobi e-naslov", Icons.save),
                  ],
                ),
              ),
            ),
          ),
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
      onPressed: disabled ? null : (() => onClick)
    );
  }
}
