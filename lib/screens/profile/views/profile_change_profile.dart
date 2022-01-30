import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/auth/models/profile/change_profile_model.dart';
import 'package:moj_student/data/auth/profile_repository.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/buttons/row_button.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/category_name_container.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
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

    return Form(
      key: _profileForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryNameContainer(categoryName: "Sprememba nastavitev profila"),
          RowContainer(
            child: TextFormField(
              initialValue: _profileModel.phone,
              onChanged: (value) => _profileModel.phone = value,
            ),
            title: "Telefonska številka",
            icon: FlutterRemix.phone_line,
          ),
          RowContainer(
            title: "Prijava na obvestila",
            icon: FlutterRemix.rss_line,
            child: Column(
              children: [
                for (Subscriptions subscription
                    in _profileModel.subscriptions ?? [])
                  CheckboxListTile(
                    activeColor: (subscription.locked ?? false)
                        ? ThemeColors.jet[200]
                        : ThemeColors.jet,
                    title: Text(subscription.name ?? ''),
                    value: subscription.selected,
                    onChanged: (value) => setState(() => subscription.selected =
                        (subscription.locked ?? false)
                            ? subscription.selected
                            : value),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
              ],
            ),
          ),
          RowButton(title: "Shrani spremembe", onPressed: () => _onSubmit(), icon: FlutterRemix.save_line,)
        ],
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
