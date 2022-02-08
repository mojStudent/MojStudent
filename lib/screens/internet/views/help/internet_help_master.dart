import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/help/internet_help_master_model.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/services/internet/internet_help/internet_help_bloc.dart';
import "package:moj_student/helpers/string_extension.dart";

class InternetHelpMasterView extends StatelessWidget {
  InternetHelpMasterView({Key? key}) : super(key: key);

  late InternetHelpMasterModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetHelpBloc, InternetHelpState>(
        builder: (ctx, state) {
      model = (state as InternetHelpMasterLoadedState).masterModel;
      var admins = state.administrators;

      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          RowSliver(
            title: "Domski administratorji",
            icon: FlutterRemix.admin_line,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var admin in admins)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              admin.name.toLowerCase().capitalize(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text("Soba ${admin.room}"),
                          ],
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          for (var osGroup in model.help)
            RowSliver(
              title: osGroup.name,
              icon: FlutterRemix.computer_line,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      Uri.parse(
                              "https://student.sd-lj.si/api/help/data/${osGroup.image}")
                          .toString(),
                      height: 64,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var os in osGroup.os)

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: GestureDetector(
                              onTap: () => context
                                  .read<InternetHelpBloc>()
                                  .add(InternetHelpLoadDetailEvent(os.path)),
                              child: Text(
                                os.name,
                                style: TextStyle(
                                    color: ThemeColors.jet,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}
