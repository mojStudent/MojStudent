import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/data/auth/models/profile/change_email_model.dart';
import 'package:moj_student/data/auth/profile_repository.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/buttons/row_button.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/category_name_container.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/save_button_widget.dart';
import 'package:moj_student/services/validators/email_validator.dart';

class ProfileChangeEmailView extends StatefulWidget {
  const ProfileChangeEmailView({Key? key}) : super(key: key);

  @override
  _ProfileChangeEmailViewState createState() => _ProfileChangeEmailViewState();
}

class _ProfileChangeEmailViewState extends State<ProfileChangeEmailView> {
  final _mailForm = GlobalKey<FormState>();
  final _emailFormModel = ChangeEmailModel("", "");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _mailForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryNameContainer(categoryName: "Sprememba e-naslova"),
          RowContainer(
            child: TextFormField(
              obscureText: false,
              decoration: InputDecoration(label: Text("Nov e-naslov")),
              validator: (value) => EmailValidator.validate(value ?? "")
                  ? null
                  : "Podani email ni pravilne oblike",
              onChanged: (value) => _emailFormModel.email = value,
            ),
            title: "Nov e-naslov",
            icon: FlutterRemix.mail_line,
          ),
          RowContainer(
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(label: Text("Trenutno geslo")),
              validator: (value) =>
                  (value?.length ?? 0) >= 3 ? null : "Geslo mora biti vnešeno",
              onChanged: (value) => _emailFormModel.password = value,
            ),
            title: "Trenutno geslo",
            icon: FlutterRemix.lock_line,
          ),
          RowButton(
            title: "Posdobi geslo",
            onPressed: () => _onSave(),
            icon: FlutterRemix.save_line,
          )
        ],
      ),
    );
  }

  Future<void> _onSave() async {
    if (!(_mailForm.currentState?.validate() ?? true)) {
      return;
    }

    FocusScope.of(context).unfocus();
    final profileRepo = ProfileRepository();
    BottomModal.showLoadingModal(context);

    try {
      await profileRepo.mailChange(_emailFormModel);
      Navigator.pop(context);
      BottomModal.showBottomModal(
        context,
        "Email je bil uspešno posodobljen",
        bodyText: "Na vnešen epoštni naslov ste prejeli nadaljna navodila.",
      );
      setState(() => _mailForm.currentState?.reset());
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
