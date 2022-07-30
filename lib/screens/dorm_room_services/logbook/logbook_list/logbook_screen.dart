import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/dorm_room_services/logbook/logbook_repo.dart';
import 'package:moj_student/data/dorm_room_services/logbook/models/logbook_list_model.dart';
import 'package:moj_student/screens/dorm_room_services/logbook/logbook_list/cubit/logbook_cubit.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/no_data.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';

class LogbookListScreen extends StatelessWidget {
  const LogbookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/logbook/new"),
        backgroundColor: ThemeColors.jet,
        child: Icon(
          FlutterRemix.add_line,
          color: Colors.white,
        ),
      ),
      body: Column(children: [
        AppHeader(title: "Dežurna knjiga"),
        Expanded(
            child: BlocProvider(
          create: (_) => LogbookCubit(LogbookRepo()),
          child: BlocBuilder<LogbookCubit, LogbookState>(
            builder: (context, state) {
              if (state is LogbookInitial) {
                context.read<LogbookCubit>().loadLogbookPage();
                return LoadingScreen(
                  withScaffold: false,
                );
              } else if (state is LogbookLoadingState) {
                return LoadingScreen(
                  withScaffold: false,
                );
              } else if (state is LogbookLoadedState) {
                return _buildWithData(context, state.model);
              } else if (state is LogbookNoDataState) {
                return NoData();
              } else if (state is LogbookErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Center(
                  child: Text("Interna napaka"),
                );
              }
            },
          ),
        ))
      ]),
    );
  }

  Widget _buildWithData(BuildContext context, LogbookListModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              for (var record in model.results)
                RowSliver(
                  title: record.date,
                  icon: FlutterRemix.calendar_2_line,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      _rowSliverTextRow("Lokacija", record.location),
                      _rowSliverTextRow("Podlokacija (soba)",
                          "${record.subLocation} ${record.room}"),
                      _rowSliverTextRow("Status", record.status),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        record.description,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (model.page > 1) {
                        context
                            .read<LogbookCubit>()
                            .loadLogbookPage(page: model.page - 1);
                      }
                    },
                    icon: Icon(
                      FlutterRemix.arrow_left_s_line,
                      color: ThemeColors.jet,
                    )),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "${model.page} / ${model.pages}",
                  style: TextStyle(
                    fontSize: 16,
                    color: ThemeColors.jet,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () {
                      if (model.page < model.pages) {
                        context
                            .read<LogbookCubit>()
                            .loadLogbookPage(page: model.page + 1);
                      }
                    },
                    icon: Icon(
                      FlutterRemix.arrow_right_s_line,
                      color: ThemeColors.jet,
                    )),
              ],
            )
          ],
        )
      ],
    );
  }

  Row _rowSliverTextRow(String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300),
        ),
        Flexible(
            child: Text(
          data,
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ))
      ],
    );
  }
}
