import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_errors_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/buttons/row_button_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/internet/admin/errors/bloc/iadmin_errors_bloc.dart';

class InternetAdminErrorScreen extends StatelessWidget {
  const InternetAdminErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) =>
          InternetAdminErrorsBloc(context.read<InternetAdminRepository>()),
      child: BlocBuilder<InternetAdminErrorsBloc, InternetAdminErrorsState>(
        builder: (context, state) {
          if (state is InternetAdminErrorsInitial) {
            context
                .read<InternetAdminErrorsBloc>()
                .add(InternetAdminErrorsLoadEvent());
            return Container();
          } else {
            return Scaffold(
              body: Column(children: [
                AppHeader(title: "Napake"),
                state is InternetAdminErrorsLoadingState
                    ? LoadingScreen(
                        withScaffold: false,
                        expanded: true,
                      )
                    : Container(),
                state is InternetAdminErrorsLoadedState
                    ? Expanded(
                        child: CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            for (var error in state.errors.results)
                              _errorCard(error, context, h, w),
                          ],
                        ),
                      )
                    : Container(),
                state is InternetAdminErrorsErrorState
                    ? Expanded(
                        child: Center(
                        child: Text(state.e.toString()),
                      ))
                    : Container()
              ]),
              floatingActionButton: _fab(context, state, h, w),
            );
          }
        },
      ),
    );
  }

  Widget _fab(
    BuildContext context,
    InternetAdminErrorsState state,
    double h,
    double w,
  ) {
    if (state is InternetAdminErrorsLoadedState) {
      return FloatingActionButton(
        onPressed: () => BottomModal.showCustomModal(context,
            height: h * 0.75,
            color: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(top: 20),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        "iskanje".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                      sliver: SliverToBoxAdapter(
                        child: Divider(
                          thickness: 1.5,
                          color: ThemeColors.jet.withOpacity(0.25),
                        ),
                      )),
                  RowSliver(
                    title: "Uporabniško ime",
                    icon: FlutterRemix.passport_line,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                          label: Text("Iskanje po uporabniškem imenu"),
                          border: InputBorder.none),
                      initialValue: (state as InternetAdminErrorsLoadedState)
                          .searchUsername,
                      onChanged: (value) => state =
                          (state as InternetAdminErrorsLoadedState)
                              .copyWith(searchUsername: value),
                    ),
                  ),
                  RowSliver(
                    title: "Opis napake",
                    icon: FlutterRemix.error_warning_line,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                          label: Text("Iskanje po opisu napake"),
                          border: InputBorder.none),
                      initialValue: (state as InternetAdminErrorsLoadedState)
                          .searchDescription,
                      onChanged: (value) => state =
                          (state as InternetAdminErrorsLoadedState)
                              .copyWith(searchDescription: value),
                    ),
                  ),
                  RowButtonSliver(
                    title: "Poišči",
                    onPressed: () {
                      context
                          .read<InternetAdminErrorsBloc>()
                          .add(InternetAdminErrorsLoadEvent(
                            searchDescription:
                                (state as InternetAdminErrorsLoadedState)
                                    .searchDescription,
                            searchUsername:
                                (state as InternetAdminErrorsLoadedState)
                                    .searchUsername,
                          ));
                      Navigator.pop(context);
                    },
                    icon: FlutterRemix.search_2_line,
                  )
                ],
              ),
            )),
        child: Icon(
          FlutterRemix.search_2_line,
          color: Colors.white,
        ),
        backgroundColor: ThemeColors.primary,
        elevation: 0,
      );
    } else {
      return Container();
    }
  }

  RowSliver _errorCard(
    IAdminErrorModel error,
    BuildContext context,
    double h,
    double w,
  ) {
    return RowSliver(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  error.date,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(FlutterRemix.passport_line, size: 20),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  error.username,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(FlutterRemix.information_line, size: 20),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  error.error,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
      onClick: () => BottomModal.showCustomModal(context,
          height: h * 0.7,
          color: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "podrobnosti napake".toUpperCase(),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SliverPadding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    sliver: SliverToBoxAdapter(
                      child: Divider(
                        thickness: 1.5,
                        color: ThemeColors.jet.withOpacity(0.25),
                      ),
                    )),
                TextRowSliver(
                  title: "Čas",
                  data: error.date,
                  icon: FlutterRemix.time_line,
                ),
                TextRowSliver(
                  title: "Uporabniško ime",
                  data: error.username,
                  icon: FlutterRemix.passport_line,
                ),
                TextRowSliver(
                  title: "NAS",
                  data: error.nas,
                  icon: FlutterRemix.database_2_line,
                ),
                TextRowSliver(
                  title: "MAC",
                  data: error.mac,
                  icon: FlutterRemix.computer_line,
                ),
                TextRowSliver(
                  title: "napaka",
                  data: error.description,
                  icon: FlutterRemix.error_warning_line,
                ),
              ],
            ),
          )),
    );
  }
}
