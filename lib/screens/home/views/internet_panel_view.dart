import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/avatars/avatar_repo.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/row_button_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/services/blocs/profile/profile_bloc.dart';

class InternetAdminPanelView extends StatelessWidget {
  const InternetAdminPanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        _body(h, w, context),
        _header(h, context, w),
      ],
    );
  }

  Stack _header(double h, BuildContext context, double w) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: h * 0.12,
          decoration: BoxDecoration(
            color: ThemeColors.primary,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: h * 0.08),
          child: Padding(
            padding: EdgeInsets.only(right: w * 0.15),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: h * 0.01),
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
                  child: Row(
                    children: [
                      Icon(FlutterRemix.database_line, color: ThemeColors.jet),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Text(
                          "Administracija interneta",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.jet),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        )
      ],
    );
  }

  Widget _body(double h, double w, BuildContext context) {
    return CustomScrollView(slivers: [
      SliverPadding(padding: EdgeInsets.only(top: h * 0.125), sliver: SliverToBoxAdapter(child: Container()),),
      CategoryNameSliver(categoryName: "Storitve administracije"),
      RowButtonSliver(title: "NAS", onPressed: () => null),
    ],);
  }
}
