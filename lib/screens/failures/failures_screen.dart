import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/failure_records/failure_record_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/no_data.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/failure_record/bloc/failure_record_bloc.dart';

// ignore: must_be_immutable
class FailuresScreen extends StatelessWidget {
  int showPageResult = 1;
  FailuresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () => Navigator.of(context).pushNamed("/failures/new"),
          child: Icon(
            FlutterRemix.add_line,
            color: Colors.white,
          ),
          backgroundColor: ThemeColors.jet,
        ),
        body: Column(
          children: [
            AppHeader(title: "Okvare"),
            Expanded(
              child: BlocBuilder<FailureRecordBloc, FailureRecordState>(
                builder: (ctx, state) {
                  if (state is FailureRecordInitial) {
                    context
                        .read<FailureRecordBloc>()
                        .add(FailureRecordLoadPageEvent(page: showPageResult));
                    return Container();
                  } else if (state is FailureRecordLoadingState) {
                    return LoadingScreen();
                  } else if (state is FailureEmptyDataState) {
                    return NoData();
                  } else if (state is FailureRecordLoadedState) {
                    return RefreshIndicator(
                        onRefresh: () async => context
                            .read<FailureRecordBloc>()
                            .add(FailureRecordLoadPageEvent(
                                page: showPageResult)),
                        child: _buildFailureRecords(context, state.model));
                  } else if (state is FailureRecordErrorState) {
                    return NotSupported();
                  } else {
                    return Center(child: Text("NAPAKA"));
                  }
                },
              ),
            )
          ],
        ));
  }

  Widget _buildFailureRecords(
      BuildContext context, FailurePaginationModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => context
                .read<FailureRecordBloc>()
                .add(FailureRecordLoadPageEvent(page: model.page)),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lokacija",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              record.location,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Podlokacija (soba)",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${record.subLocation} ${record.room}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              record.status,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
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
                      if (showPageResult > 1) {
                        showPageResult--;
                        context.read<FailureRecordBloc>().add(
                            FailureRecordLoadPageEvent(page: showPageResult));
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
                      if (showPageResult < model.pages) {
                        showPageResult++;
                        context.read<FailureRecordBloc>().add(
                            FailureRecordLoadPageEvent(page: showPageResult));
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
}
