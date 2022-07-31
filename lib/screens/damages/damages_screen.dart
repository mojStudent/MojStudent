// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/no_data.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/damage-record/damage_record_bloc.dart';
import 'package:moj_student/services/files/file_downloader.dart';

class DamagesScreen extends StatelessWidget {
  int showPageResult = 1;

  DamagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppHeader(title: "Škodni zapisniki"),
        Expanded(
          child: BlocBuilder<DamageRecordBloc, DamageRecordState>(
            builder: (ctx, state) {
              if (state is DamageRecordInitial) {
                context
                    .read<DamageRecordBloc>()
                    .add(DamageRecordLoadPageEvent(page: showPageResult));
                return Container();
              } else if (state is DamageRecordLoadingState) {
                return LoadingScreen();
              } else if (state is DamageRecordEmptyState) {
                return NoData();
              } else if (state is DamageRecordLoadedState) {
                return RefreshIndicator(
                    onRefresh: () async => context
                        .read<DamageRecordBloc>()
                        .add(DamageRecordLoadPageEvent(page: showPageResult)),
                    child: _buildDamageRecords(context, state.model));
              } else if (state is DamageRecordErrorState) {
                return NotSupported();
              } else {
                return Center(child: Text("NAPAKA"));
              }
            },
          ),
        ),
      ],
    ));
  }

  Widget _buildDamageRecords(
      BuildContext context, SkodniZapisnikPaginationModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            for (var record in model.results)
              RowSliver(
                title: record.created,
                icon: FlutterRemix.calendar_2_line,
                child: GestureDetector(
                    onTap: () async {
                      final url = "https://student.sd-lj.si${record.url}";
                      final bearer = "Bearer " + AuthRepository().token!;
                      BottomModal.showFileDownloading(context);
                      await FileDownloader.openFileFromUrl(
                          url: url,
                          filename: record.filename,
                          getFilenameFromHeader: false,
                          bearer: bearer);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            record.filename.split(".")[0],
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        Icon(
                          Icons.download,
                          size: 28,
                          color: ThemeColors.blue,
                        ),
                      ],
                    )),
              )
          ],
        )),
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
                        context.read<DamageRecordBloc>().add(
                            DamageRecordLoadPageEvent(page: showPageResult));
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
                        context.read<DamageRecordBloc>().add(
                            DamageRecordLoadPageEvent(page: showPageResult));
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
