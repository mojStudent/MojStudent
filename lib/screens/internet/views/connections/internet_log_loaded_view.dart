import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/internet/models/internet_log_model.dart';
import 'package:moj_student/screens/internet/views/connections/cubit/internet_log_cubit.dart';
import 'package:moj_student/screens/internet/views/connections/internet_log_detail_screen.dart';

class InternetLogLoadedView extends StatelessWidget {
  final List<InternetConnectionLogModel> connections;

  const InternetLogLoadedView({Key? key, required this.connections})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetLogCubit(),
      child: BlocBuilder<InternetLogCubit, InternetLogState>(
        builder: (context, state) {
          if (state is InternetLogInitial) {
            //delay so that it works, idk =D
            Future.delayed(Duration(seconds: 1)).then((value) =>
                context.read<InternetLogCubit>().initialize(connections));
            return Container();
          } else if (state is InternetLogLoadedState) {
            return _buildData(state.getConnections(), context);
          } else {
            return Center(child: Text("Napaka še sam ne vem kakšna"));
          }
        },
      ),
    );
  }

  Column _buildData(
      List<InternetConnectionLogModel> dataBuild, BuildContext context) {
    final state =
        context.read<InternetLogCubit>().state as InternetLogLoadedState;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: GestureDetector(
                  onTap: () => context
                      .read<InternetLogCubit>()
                      .filterActive(connections, false),
                  child: Chip(
                    backgroundColor: state.showOnlyActive
                        ? Colors.white
                        : Color.alphaBlend(ThemeColors.jet.withOpacity(0.5),
                            ThemeColors.primary),
                    label: Text(
                      "Vse",
                      style: TextStyle(
                          color: state.showOnlyActive
                              ? Color.alphaBlend(
                                  ThemeColors.jet.withOpacity(0.5),
                                  ThemeColors.primary)
                              : Colors.white),
                    ),
                    avatar: CircleAvatar(
                      child: Icon(
                        Icons.airplanemode_active,
                        size: 14,
                        color: !state.showOnlyActive
                            ? Colors.white
                            : ThemeColors.jet,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: GestureDetector(
                  onTap: () => context
                      .read<InternetLogCubit>()
                      .filterActive(connections, true),
                  child: Chip(
                    backgroundColor: !state.showOnlyActive
                        ? Colors.white
                        : Color.alphaBlend(ThemeColors.jet.withOpacity(0.5),
                            ThemeColors.primary),
                    label: Text(
                      "Aktivne",
                      style: TextStyle(
                        color: !state.showOnlyActive
                            ? Color.alphaBlend(ThemeColors.jet.withOpacity(0.5),
                                ThemeColors.primary)
                            : Colors.white,
                      ),
                    ),
                    avatar: CircleAvatar(
                      child: Icon(
                        Icons.wifi,
                        size: 14,
                        color: state.showOnlyActive
                            ? Colors.white
                            : ThemeColors.jet,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: dataBuild.length,
            itemBuilder: (context, index) {
              var log = dataBuild.elementAt(index);
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02,
                    vertical: MediaQuery.of(context).size.height * 0.005),
                child: TextButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        textStyle: TextStyle(color: Colors.black)),
                    onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                InternetLogDetailScreen(log: log),
                          ),
                        ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          log.status == 0 ? 0 : 5, 10, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [_connectionTypeIndicator(log)],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              log.status == 0
                                  ? _activeConnectionData(log)
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${log.sessionTime} s",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.timer,
                                              color: Colors.black,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              log.terminate,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.black,
                                              size: 16,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _connectionTypeIndicator(InternetConnectionLogModel log) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                log.status == 0
                    ? Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Icon(
                          Icons.check_circle,
                          color: ThemeColors.primary,
                          size: 18,
                        ),
                      )
                    : Container(),
                Text(
                  "${log.nas?.location}",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          log.nas?.location == 'WiFi' ? Icons.wifi : Icons.cable,
          color: Colors.black,
          size: 18,
        ),
      ],
    );
  }

  Widget _activeConnectionData(InternetConnectionLogModel log) {
    return Row(
      children: [
        Text(
          "IP: ${log.ip}",
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.network_check_outlined,
          color: Colors.black,
          size: 20,
        ),
      ],
    );
  }
}
