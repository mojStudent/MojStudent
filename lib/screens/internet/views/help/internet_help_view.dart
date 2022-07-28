import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/screens/internet/views/help/internet_help_master.dart';
import 'package:moj_student/screens/internet/views/help/internet_help_step.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';
import 'package:moj_student/services/internet/internet_help/internet_help_bloc.dart';

class InternetHelpView extends StatelessWidget {
  const InternetHelpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetHelpBloc, InternetHelpState>(
        builder: (ctx, state) {
      if (state is InternetHelpLoadingState) {
        return LoadingScreen();
      } else if (state is InternetHelpInitial) {
        context.read<InternetHelpBloc>().add(InternetHelpLoadMasterEvent());
      } else if (state is InternetHelpMasterLoadedState) {
        return InternetHelpMasterView();
      } else if (state is InternetHelpDetailLoadedState) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InternetHelpDetailView(
                  steps: state.model,
                ),
              ),
            );
            context.read<InternetHelpBloc>().add(InternetHelpLoadMasterEvent());
          },
        );
        return Container();
      }

      context.read<InternetHelpBloc>().add(InternetHelpLoadMasterEvent());
      //napaka
      return NotSupported();
    });
  }
}
