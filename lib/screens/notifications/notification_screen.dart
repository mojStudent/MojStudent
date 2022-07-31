import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/notifications/notification_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/notification/notification_bloc.dart';
import 'package:moj_student/services/blocs/notification/notification_events.dart';
import 'package:moj_student/services/blocs/notification/notification_states.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppHeader(title: "Obvestila"),
        Expanded(
          child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (ctx, state) {
            if (state is InitialNotificationState) {
              context.read<NotificationBloc>().add(LoadNotifications());
              return LoadingScreen();
            } else if (state is NotificationsLoading ||
                state is NotificationDetailLoading ||
                state is DataLoading) {
              return LoadingScreen();
            } else if (state is NotificationsLoaded) {
              return _buildNotificationsList(context, state.notifications);
            } else if (state is NotificationDetailLoaded) {
              Future.delayed(Duration.zero, () {
                Navigator.of(context).pushNamed('/notification');
              });

              return Container();
            } else if (state is DataLoadingError) {
              return Container();
            } else {
              return Center(child: Text("Napaka programa"));
            }
          }),
        )
      ],
    ));
  }

  Widget _buildNotificationsList(
      BuildContext context, List<NotificationModel> notifications) {
    List<Widget> list = [];
    for (var d in notifications) {
      list.add(buildNotificationRow(d, context));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Dismissible(
          key: Key(index.toString()),
          confirmDismiss: (direction) async {
            if (!notifications[index].read) {
              context.read<NotificationBloc>().add(SetNotificationAsRead(
                  notificationId: notifications[index].id));
            }
            return false;
          },
          child: list[index],
          background: index == 0 || notifications[index].read
              ? Container()
              : Container(
                  color: ThemeColors.warning,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.mark_email_read,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )),
        );
      },
    );
  }

  Widget buildNotificationRow(
      NotificationModel notification, BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
      margin: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.0075),
      decoration: BoxDecoration(
          color: notification.read ? Colors.white : ThemeColors.jet,
          borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () => context
            .read<NotificationBloc>()
            .add(LoadNotification(notificationId: notification.id)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: w * 0.025,
                  child: Divider(
                    thickness: 1.5,
                    color:
                        notification.read ? ThemeColors.jet[300] : Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                  child: Text(
                    notification.date,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: notification.read ? ThemeColors.jet : Colors.white,
                    ),
                  ),
                ),
                !notification.read
                    ? Padding(
                        padding: EdgeInsets.only(right: w * 0.01),
                        child: Icon(
                          FlutterRemix.notification_3_line,
                          color: notification.read
                              ? ThemeColors.jet
                              : Colors.white,
                          size: 15,
                        ),
                      )
                    : Container(),
                Expanded(
                    child: Divider(
                  thickness: 1.5,
                  color:
                      notification.read ? ThemeColors.jet[300] : Colors.white,
                )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.02, top: h * 0.005),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      notification.subject,
                      style: TextStyle(
                          color: notification.read
                              ? ThemeColors.jet
                              : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
