import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/damage-record/damage_record_model.dart';
import 'package:moj_student/screens/drawer/app_drawer.dart';
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
          backgroundColor: AppColors.success,
          centerTitle: true,
          elevation: 0,
        ),
        drawer: AppDrawer(),
        body: BlocBuilder<DamageRecordBloc, DamageRecordState>(
          builder: (ctx, state) {
            if (state is DamageRecordInitial) {
              context
                  .read<DamageRecordBloc>()
                  .add(DamageRecordLoadPageEvent(page: showPageResult));
              return Container();
            } else if (state is DamageRecordLoadingState) {
              return _loadingScreen();
            } else if (state is DamageRecordLoadedState) {
              return _buildDamageRecords(context, state.model);
            } else if (state is DamageRecordErrorState) {
              return NotSupported();
            } else {
              return Center(child: Text("NAPAKA"));
            }
          },
        ));
  }

  Widget _loadingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDamageRecords(
      BuildContext context, SkodniZapisnikPaginationModel model) {
    return Column(
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
                IconButton(onPressed: () {
                  if (showPageResult > 1) {
                        showPageResult--;
                        context.read<DamageRecordBloc>().add(
                            DamageRecordLoadPageEvent(page: showPageResult));
                      }
                }, icon: Icon(Icons.arrow_back)),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "${model.page} / ${model.pages}",
                  style: TextStyle(fontSize: 16),
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
                    icon: Icon(Icons.arrow_forward)),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _buildDamageRecordTile(
      BuildContext context, DamageRecordModel record) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.005),
      child: ElevatedButton(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final url = "https://student.sd-lj.si${record.url}";
                      final bearer = "Bearer " + AuthRepository().token!;
                      _showDownloadInProgress(context);
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            record.filename.split(".")[0],
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            record.created,
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )),
          style: ElevatedButton.styleFrom(primary: Colors.white),
          onPressed: () {}),
    );
  }

  void _showDownloadInProgress(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            color: AppColors.green,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Prenašanje datoteke',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // TextButton(
                //   child: Text(
                //     'Prekliči',
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   onPressed: () => Navigator.pop(context),
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
