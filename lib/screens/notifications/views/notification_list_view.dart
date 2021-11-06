import 'package:flutter/material.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/notifications/notification_model.dart';
import 'package:moj_student/services/notification/notification_bloc.dart';
import 'package:moj_student/services/notification/notification_events.dart';
import 'package:moj_student/services/notification/notification_states.dart';

class NotificationListView extends StatelessWidget {
  final NotificationBloc bloc;
  const NotificationListView({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    var dataList = (bloc.state as NotificationsLoaded).notifications;

    for (var d in dataList) {
      list.add(_buildNotificationRow(d, context));
    }

    return 
    ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Dismissible(
          key: Key(index.toString()),
          confirmDismiss: (direction) async {
            return false;
          },
          child: list[index],
          background: Container(
              color: AppColors.yellow,
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

  Widget _buildNotificationRow(
      NotificationModel notification, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025,
          vertical: MediaQuery.of(context).size.height * 0.005),
      child: ElevatedButton(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.015,
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Column(
              children: [
                Row(
                  children: [
                    notification.read
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.mark_email_unread_outlined,
                              color: AppColors.yellow,
                            ),
                          )
                        : Container(),
                    Flexible(
                      child: Text(
                        notification.subject,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        notification.date,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.white),
          onPressed: () {
            bloc.add(LoadNotification(notificationId: notification.id));
          }),
    );
  }
}
