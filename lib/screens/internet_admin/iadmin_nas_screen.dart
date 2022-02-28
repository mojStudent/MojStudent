import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_nas_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/internet/admin/nas/iadmin_nas_bloc.dart';

class InternetAdminNasScreen extends StatelessWidget {
  const InternetAdminNasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetAdminNasBloc, InternetAdminNasState>(
        builder: (context, state) {
      if (state is InternetAdminNasLoadingState) {
        return LoadingScreen();
      } else if (state is InternetAdminNasInitial) {
        context.read<InternetAdminNasBloc>().add(InternetAdminNasLoadEvent());
        return Container();
      } else {
        return Scaffold(
          body: Column(children: [
            AppHeader(title: "NAS status"),
            if (state is InternetAdminNasLoadedState) _loadWithData(state.data),
            if (state is InternetAdminNasErrorState)
              Expanded(child: Center(child: Text(state.e.toString()))),
          ]),
        );
      }
    });
  }

  Expanded _loadWithData(List<InternetAdminNasModel> data) {
    return Expanded(
        child: CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        for (var nas in data)
          RowSliver(
            title: nas.location,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      FlutterRemix.computer_line,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(nas.name)
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      FlutterRemix.database_2_line,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(nas.shortName)
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      nas.active
                          ? FlutterRemix.checkbox_circle_fill
                          : FlutterRemix.error_warning_fill,
                      size: 20,
                      color: nas.active ? ThemeColors.primary : Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text(nas.active ? "Gor" : "Dol",
                        style: TextStyle(fontWeight: FontWeight.w800))
                  ],
                ),
              ],
            ),
          ),
        RowSliver(
          title: "dom 1",
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    FlutterRemix.computer_line,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text("88.200.100.99")
                ],
              ),
              Row(
                children: [
                  Icon(
                    FlutterRemix.database_2_line,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text("sbl-1-1")
                ],
              ),
              Row(
                children: [
                  Icon(
                    FlutterRemix.error_warning_fill,
                    size: 20,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Dol",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
