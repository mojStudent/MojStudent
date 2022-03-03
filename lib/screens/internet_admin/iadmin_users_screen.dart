import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_location_model.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_users_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/containers/row_container.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/services/internet/admin/users/iadmin_users_bloc.dart';

class InternetAdminUsersScreen extends StatelessWidget {
  const InternetAdminUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return BlocBuilder<InternetAdminUsersBloc, InternetAdminUsersState>(
        builder: (context, state) {
      if (state is InternetAdminUsersInitial) {
        context
            .read<InternetAdminUsersBloc>()
            .add(InternetAdminUsersLoadLocationsEvent());
        return LoadingScreen();
      } else if (state is InternetAdminUsersLoadingState) {
        return LoadingScreen();
      } else if (state is InternetAdminUsersLoadedState) {
        return _loadedData(h, context, w, state);
      } else if (state is InternetAdminUsersLocationsLoadedState) {
        context
            .read<InternetAdminUsersBloc>()
            .add(InternetAdminUsersLoadDataEvent(
              locations: state.locations,
              location: state.locations.firstWhere((element) => element.home),
            ));
        return LoadingScreen();
      } else if (state is InternetAdminUsersErrorState) {
        return Scaffold(
          body: Center(
            child: Text("Napaka"),
          ),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text("Napaka, še sam ne vem kakšna"),
          ),
        );
      }
    });
  }

  Scaffold _loadedData(double h, BuildContext context, double w,
      InternetAdminUsersLoadedState state) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: h * 0.2),
              ),
              for (var user in state.data?.results ?? [])
                _buildUserCard(context, user),
              SliverToBoxAdapter(
                child: SizedBox(height: h * 0.1),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(h, context, w, state),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, h * 0.025),
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04, vertical: h * 0.015),
                width: w * 0.65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: ThemeColors.jet.withOpacity(0.3),
                        offset: Offset(3, 2),
                        blurRadius: 5)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => state.page > 1
                          ? context
                              .read<InternetAdminUsersBloc>()
                              .add(InternetAdminUsersLoadDataEvent.fromState(
                                state,
                                page: state.page - 1,
                              ))
                          : null,
                      child: Icon(FlutterRemix.arrow_left_s_line),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${state.page} / ${state.data?.pages}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => state.page < (state.data?.pages ?? 0)
                          ? context
                              .read<InternetAdminUsersBloc>()
                              .add(InternetAdminUsersLoadDataEvent.fromState(
                                state,
                                page: state.page + 1,
                              ))
                          : null,
                      child: Icon(FlutterRemix.arrow_right_s_line),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: _fab(context, w, state),
    );
  }

  SliverToBoxAdapter _buildUserCard(
      BuildContext context, InternetAdminUserModel user) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          "/internet/admin/users/details",
          arguments: user.id,
        ),
        child: RowContainer(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${user.firstname} ${user.lastname}".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                Divider(),
                Row(
                  children: [
                    Icon(
                      FlutterRemix.building_line,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Soba ${user.room}, ${user.location}")
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      FlutterRemix.passport_line,
                      size: 18,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(user.username)
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  FloatingActionButton _fab(
      BuildContext context, double w, InternetAdminUsersLoadedState state) {
    return FloatingActionButton(
      onPressed: () => BottomModal.showCustomModal(context,
          color: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "Filtri".toUpperCase(),
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
                RowSliver(
                  title: "Lokacija",
                  icon: FlutterRemix.building_line,
                  child: DropdownButton<InternetAdminLocationModel>(
                      focusColor: Colors.white,
                      isExpanded: true,
                      value: state.selectedLocation ??
                          state.locations.firstWhere((element) => element.home),
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: [
                        for (var location in state.locations)
                          DropdownMenuItem(
                            child: Text(
                              location.name,
                              style: TextStyle(color: Colors.black),
                            ),
                            value: location,
                          ),
                      ],
                      onChanged: (value) {
                        context.read<InternetAdminUsersBloc>().add(
                            InternetAdminUsersLoadDataEvent.fromState(state,
                                location: value));
                        Navigator.of(context).pop();
                      }),
                ),
                RowSliver(
                  title: "Število zadetkov na stran",
                  icon: FlutterRemix.numbers_line,
                  child: DropdownButton<int>(
                      focusColor: Colors.white,
                      isExpanded: true,
                      value: state.perPage,
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "10",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "20",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: 20,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "50",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: 50,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "100",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: 100,
                        ),
                      ],
                      onChanged: (value) {
                        context
                            .read<InternetAdminUsersBloc>()
                            .add(InternetAdminUsersLoadDataEvent.fromState(
                              state,
                              perPage: value,
                            ));
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
          )),
      child: Icon(
        FlutterRemix.filter_3_line,
        color: Colors.white,
      ),
      elevation: 0,
      backgroundColor: ThemeColors.primary,
    );
  }

  Stack _header(double h, BuildContext context, double w,
      InternetAdminUsersLoadedState state) {
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
                  child: TextFormField(
                    obscureText: false,
                    decoration: InputDecoration(
                        label: Row(children: [
                          Icon(
                            FlutterRemix.search_2_line,
                            size: 20,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Iskanje")
                        ]),
                        border: InputBorder.none),
                    initialValue: state.searchTerm,
                    onFieldSubmitted: (value) => context
                        .read<InternetAdminUsersBloc>()
                        .add(InternetAdminUsersLoadDataEvent.fromState(
                          state,
                          search: value,
                        )),
                  )),
            ),
          ),
        )
      ],
    );
  }
}
