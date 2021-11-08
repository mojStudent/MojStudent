import 'package:flutter/material.dart';
import 'package:moj_student/data/auth/models/profile/change_password_model.dart';
import 'package:moj_student/data/auth/profile_repository.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/save_button_widget.dart';
import 'package:moj_student/services/validators/minimal_len_validator.dart';
import 'package:moj_student/services/validators/same_text_validator.dart';

class ProfileChangePasswordView extends StatefulWidget {
  const ProfileChangePasswordView({Key? key}) : super(key: key);

  @override
  _ProfileChangePasswordViewState createState() =>
      _ProfileChangePasswordViewState();
}

class _ProfileChangePasswordViewState extends State<ProfileChangePasswordView> {
  final _passwordForm = GlobalKey<FormState>();
  final _passwordModel = ChangePasswordModel("", "", "");

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      title: "Sprememba gesla",
      cardBody: Form(
        key: _passwordForm,
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(label: Text("Trenutno geslo")),
              validator: (value) =>
                  MinimalLengthValidator.validate(value ?? '', 3)
                      ? null
                      : "Geslo mora biti dolgo vsaj tri znake",
              onChanged: (value) => _passwordModel.current = value,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(label: Text("Novo geslo")),
              validator: (value) =>
                  MinimalLengthValidator.validate(value ?? '', 3)
                      ? null
                      : "Geslo mora biti dolgo vsaj tri znake",
              onChanged: (value) => _passwordModel.newPass = value,
            ),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(label: Text("Ponovi novo geslo")),
              validator: (value) => SameTextValidator.validate(
                      _passwordModel.newPass, value ?? "")
                  ? !SameTextValidator.validate(
                          _passwordModel.current, value ?? "")
                      ? null
                      : "Novo geslo ne more biti enako staremu"
                  : "Novi gesli se ne ujemata",
              onChanged: (value) => _passwordModel.repeat = value,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            SaveButton(
              text: "Posodobi geslo",
              onClick: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!(_passwordForm.currentState?.validate() ?? true)) {
      return;
    }

    FocusScope.of(context).unfocus();
    final profileRepo = ProfileRepository();
    BottomModal.showLoadingModal(context);

    try {
      await profileRepo.passwordChange(_passwordModel);
      Navigator.pop(context);
      BottomModal.showBottomModal(
        context,
        "Geslo je bilo uspešno posodobljeno",
      );
      setState(() => _passwordForm.currentState?.reset());
    } catch (e) {
      Navigator.pop(context);
      BottomModal.showBottomModal(
        context,
        "Prišlo je do napake",
        bodyText: "Poskusite ponovno kasneje",
        icon: Icons.error_outline,
      );
    }
  }
}
