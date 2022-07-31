import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/data/auth/models/profile/change_password_model.dart';
import 'package:moj_student/data/auth/profile_repository.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/buttons/row_button.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/category_name_container.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
import 'package:moj_student/screens/widgets/modal.dart';
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
    return Form(
      key: _passwordForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryNameContainer(categoryName: "Sprememba gesla"),
          RowContainer(
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
              ],
            ),
            title: "Trenutno geslo",
            icon: FlutterRemix.lock_line,
          ),
          RowContainer(
            child: Column(
              children: [
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
              ],
            ),
            title: "Novo geslo",
            icon: FlutterRemix.lock_unlock_line,
          ),
          RowButton(
            title: "Posodobi geslo",
            onPressed: () => _onSubmit(),
            icon: FlutterRemix.save_line,
          )
        ],
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
