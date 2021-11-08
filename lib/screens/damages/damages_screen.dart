// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';
import 'package:moj_student/services/damage-record/damage_record_bloc.dart';
import 'package:moj_student/services/files/file_downloader.dart';

class DamagesScreen extends StatelessWidget {
  int showPageResult = 1;
  DamagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Škodni zapisniki"),
          backgroundColor: AppColors.raisinBlack[500],
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: AppColors.green,
        body: BlocBuilder<DamageRecordBloc, DamageRecordState>(
          builder: (ctx, state) {
            if (state is DamageRecordInitial) {
              context
                  .read<DamageRecordBloc>()
                  .add(DamageRecordLoadPageEvent(page: showPageResult));
              return Container();
            } else if (state is DamageRecordLoadingState) {
              return LoadingScreen();
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
        ));
  }

  Widget _buildDamageRecords(
      BuildContext context, SkodniZapisnikPaginationModel model) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: model.hits,
              itemBuilder: (BuildContext ctxt, int index) =>
                  _buildDamageRecordTile(context, model.results[index]),
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
                          context.read<DamageRecordBloc>().add(
                              DamageRecordLoadPageEvent(page: showPageResult));
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${model.page} / ${model.pages}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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
                        Icons.arrow_forward,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDamageRecordTile(
      BuildContext context, DamageRecordModel record) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.0025),
      child: Card(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Row(
              children: [
                GestureDetector(
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
                  child: Icon(
                    Icons.download,
                    size: 28,
                    color: AppColors.blue,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.filename.split(".")[0],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        record.created,
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
