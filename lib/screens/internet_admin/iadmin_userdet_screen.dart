import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/constants/math.dart';
import 'package:moj_student/data/auth/models/auth/user_model.dart';
import 'package:moj_student/data/internet/admin/iadmin_repo.dart';
import 'package:moj_student/data/internet/admin/models/iadmin_users_model.dart';
import 'package:moj_student/data/internet/internet_repo.dart';
import 'package:moj_student/data/internet/models/internet_traffic_model.dart';
import 'package:moj_student/screens/internet/views/charts/internet_traffic_chart.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/category_name_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/internet/admin/user_details/iadmin_userdet_bloc.dart';

class InternetAdminUserDetailScreen extends StatelessWidget {
  const InternetAdminUserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as int;

    return BlocProvider(
        create: (context) =>
            InternetAdminUserDetBloc(context.read<InternetAdminRepository>()),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
                title: Text("Pregled uporabnika"),
                centerTitle: true,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    FlutterRemix.arrow_left_s_line,
                    color: Colors.white,
                  ),
                ),
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(
                        FlutterRemix.user_fill,
                        color: Colors.white,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        FlutterRemix.bar_chart_fill,
                        color: Colors.white,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        FlutterRemix.file_list_3_fill,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
            body: BlocBuilder<InternetAdminUserDetBloc,
                InternetAdminUserDetState>(
              builder: (context, state) {
                if (state is InternetAdminUserDetInitial) {
                  context
                      .read<InternetAdminUserDetBloc>()
                      .add(InternetAdminUserDetLoadEvent(userId));
                  return Container();
                } else if (state is InternetAdminUserDetLoadingState) {
                  return LoadingScreen(
                    withScaffold: false,
                  );
                } else if (state is InternetAdminUserDetLoadedState) {
                  return TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      _showUserDetInfo(state.user),
                      _trafficTab(context, state.traffic),
                      _showUserDetInfo(state.user),
                    ],
                  );
                } else if (state is InternetAdminUserDetErrorState) {
                  return Center(child: Text(state.e.toString()));
                } else {
                  return Center(child: Text("Napaka, še sam ne vem kakšna"));
                }
              },
            ),
          ),
        ));
  }

  Column _showUserDetInfo(InternetAdminUserModel user) {
    return Column(children: [
      Expanded(
          child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CategoryNameSliver(categoryName: "Podatki o uporabniku"),
          TextRowSliver(
            title: "Ime in priimek",
            data: "${user.firstname} ${user.lastname}",
            icon: FlutterRemix.user_line,
          ),
          TextRowSliver(
            title: "Lokacija",
            data: "${user.location}, ${user.campus}",
            icon: FlutterRemix.building_line,
          ),
          TextRowSliver(
            title: "Soba",
            data: user.room,
            icon: FlutterRemix.home_3_line,
          ),
          TextRowSliver(
            title: "Uporabniško ime",
            data: user.username,
            icon: FlutterRemix.passport_line,
          ),
          TextRowSliver(
              title: "E-pošta",
              data: user.email ?? '',
              icon: FlutterRemix.mail_line),
          TextRowSliver(
            title: "Telefon",
            data: user.phone ?? '',
            icon: FlutterRemix.phone_line,
          ),
        ],
      ))
    ]);
  }

  Widget _trafficTab(BuildContext context, InternetTrafficModel data) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverPadding(padding: EdgeInsets.only(top: 20)),
        RowSliver(
          title: "Prenos gor v tem tednu",
          icon: FlutterRemix.upload_2_line,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.weeks[0].value.human,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    " / ${data.weeks[0].limit.human}",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                child: LinearProgressIndicator(
                  color: Colors.red,
                  backgroundColor: ThemeColors.primary[400],
                  minHeight: 10,
                  value: (data.weeks[0].progress) / 100.0,
                ),
              )
            ],
          ),
        ),
        RowSliver(
          title: "Količina prenosa",
          icon: FlutterRemix.arrow_up_down_line,
          child: Column(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: InternetTrafficChart.createChart(data)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Prenos gor"),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 15,
                    height: 10,
                    color: Colors.red,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Prenos dol"),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 15,
                    height: 10,
                    color: ThemeColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
        RowSliver(
          title: "Prenos v tem tednu",
          icon: FlutterRemix.loader_2_line,
          child: Column(children: [
            for (int i = (data.days.data.labels.length) - 7;
                i < (data.days.data.labels.length);
                i++)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.days.data.labels[i],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Column(children: [
                          Row(
                            children: [
                              Text(
                                "${AppMath.divideAndFormat(data: data.days.data.datasets[1].data[i])} GB",
                                style: TextStyle(fontSize: 12),
                              ),
                              Icon(
                                Icons.download,
                                color: ThemeColors.primary[700],
                                size: 20,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${AppMath.divideAndFormat(data: data.days.data.datasets[0].data[i])} GB",
                                style: TextStyle(fontSize: 12),
                              ),
                              Icon(
                                Icons.file_upload,
                                color: Colors.red[300],
                                size: 20,
                              ),
                            ],
                          ),
                        ])
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                  )
                ],
              )
          ]),
        ),
        SliverPadding(padding: EdgeInsets.only(top: 20)),
      ],
    );
  }
}
