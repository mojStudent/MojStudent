import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/failure_records/failure_record_model.dart';
import 'package:moj_student/screens/drawer/app_drawer.dart';
import 'package:moj_student/screens/widgets/not_supported.dart';
import 'package:moj_student/services/failure_record/bloc/failure_record_bloc.dart';

class FailuresScreen extends StatelessWidget {
  int showPageResult = 1;
  FailuresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Okvare"),
          backgroundColor: AppColors.success,
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed("/failures/new"),
          child: Icon(Icons.add),
        ),
        drawer: AppDrawer(),
        body: BlocBuilder<FailureRecordBloc, FailureRecordState>(
          builder: (ctx, state) {
            if (state is FailureRecordInitial) {
              context
                  .read<FailureRecordBloc>()
                  .add(FailureRecordLoadPageEvent(page: showPageResult));
              return Container();
            } else if (state is FailureRecordLoadingState) {
              return _loadingScreen();
            } else if (state is FailureRecordLoadedState) {
              return RefreshIndicator(
                  onRefresh: () async => context
                      .read<FailureRecordBloc>()
                      .add(FailureRecordLoadPageEvent(page: showPageResult)),
                  child: _buildFailureRecords(context, state.model));
            } else if (state is FailureRecordErrorState) {
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

  Widget _buildFailureRecords(
      BuildContext context, FailurePaginationModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: model.results.length,
            itemBuilder: (BuildContext ctxt, int index) =>
                _buildFailureRecordTile(context, model.results[index]),
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
                    icon: Icon(Icons.arrow_back)),
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
                        context.read<FailureRecordBloc>().add(
                            FailureRecordLoadPageEvent(page: showPageResult));
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

  Widget _buildFailureRecordTile(BuildContext context, FailureModel record) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.005),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Colors.black), primary: Colors.white),
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        record.date,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      )
                    ],
                  ),
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
                        "${record.location}",
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
                        "${record.status}",
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
              )),
          onPressed: () {}),
    );
  }
}
