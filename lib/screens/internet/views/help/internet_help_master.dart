import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/help/internet_help_master_model.dart';
import 'package:moj_student/screens/internet/views/help/internet_help_step.dart';
import 'package:moj_student/screens/widgets/box_widget.dart';
import 'package:moj_student/services/internet/internet_help/internet_help_bloc.dart';

class InternetHelpMasterView extends StatelessWidget {
  InternetHelpMasterView({Key? key}) : super(key: key);

  late InternetHelpMasterModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetHelpBloc, InternetHelpState>(
        builder: (ctx, state) {
      model = (state as InternetHelpMasterLoadedState).masterModel;

      return CustomScrollView(
        slivers: [
          for (var osGroup in model.help)
            SliverToBoxAdapter(
              child: BoxWidget(
                title: osGroup.name,
                cardBody: Padding(
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
                                      color: AppColors.blue[800],
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
            )
        ],
      );
    });
  }
}