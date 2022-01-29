import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/auth/models/profile/change_profile_model.dart';
import 'package:moj_student/data/auth/profile_repository.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/save_button_widget.dart';

class ProfileChangeProfileView extends StatefulWidget {
  const ProfileChangeProfileView({Key? key}) : super(key: key);

  @override
  _ProfileChangeProfileViewState createState() =>
      _ProfileChangeProfileViewState();
}

class _ProfileChangeProfileViewState extends State<ProfileChangeProfileView> {
  final _profileForm = GlobalKey<FormState>();
  UserModel? _userModel;
  late ChangeProfileModel _profileModel;

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepository();
    _userModel = authRepo.loggedInUser;
    if (_userModel != null) {
      _profileModel = ChangeProfileModel(
        phone: _userModel?.phone,
        subscriptions: _userModel?.subscriptions,
      );
    }

    if (_userModel == null) {
      //napaka
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }

    return BoxWidget(
      title: "Sprememba nastavitev profila",
      elevated: false,
      cardBody: Form(
        key: _profileForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: _profileModel.phone,
              decoration: InputDecoration(label: Text("Telefonska številka")),
              onChanged: (value) => _profileModel.phone = value,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Text("Prijava na obvestila"),
            for (Subscriptions subscription
                in _profileModel.subscriptions ?? [])
              CheckboxListTile(
                activeColor: (subscription.locked ?? false)
                    ? AppColors.jet[200]
                    : AppColors.jet,
                title: Text(subscription.name ?? ''),
                value: subscription.selected,
                onChanged: (value) => setState(() => subscription.selected =
                    (subscription.locked ?? false)
                        ? subscription.selected
                        : value),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            SaveButton(
              text: "Posodobi profil",
              onClick: _onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    FocusScope.of(context).unfocus();
    final profileRepo = ProfileRepository();
    BottomModal.showLoadingModal(context);

    try {
      await profileRepo.profileChange(_profileModel);
      Navigator.pop(context);
      BottomModal.showBottomModal(
        context,
        "Profil je bil uspešno posodobljen",
      );
      setState(() => _profileForm.currentState?.reset());
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
