import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/notifications/notification_model.dart';
import 'package:moj_student/screens/loading/loading_screen.dart';
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
      backgroundColor: AppColors.green,
        appBar: AppBar(
          backgroundColor: AppColors.raisinBlack.withOpacity(0.5),
          title: Text("Obvestila"),
          centerTitle: true,
          elevation: 0,
          // actions: [
          //   IconButton(onPressed: () => null, icon: Icon(Icons.edit)),
          // ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => null,
        //   backgroundColor: AppColors.primaryBlue,
        //   child: Icon(Icons.search),
        // ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
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

            return Scaffold ();
          } else if (state is DataLoadingError) {
            return Container();
          } else {
            return Center(child: Text("Napaka programa"));
          }
        }));
  }

  Widget _buildNotificationsList(
      BuildContext context, List<NotificationModel> notifications) {
    List<Widget> list = [
      SizedBox(
        height: 20,
      )
    ];
    for (var d in notifications) {
      list.add(_buildNotificationRow(d, context));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return Dismissible(
          key: Key(index.toString()),
          confirmDismiss: (direction) async {
            if (!notifications[index - 1].read) {
              context.read<NotificationBloc>().add(SetNotificationAsRead(
                  notificationId: notifications[index - 1].id));
            }
            return false;
          },
          child: list[index],
          background: index == 0 || notifications[index - 1].read
              ? Container()
              : Container(
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
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: ElevatedButton(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.015,
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Column(
              children: [
                Row(
                  children: [
                    !notification.read
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
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
            context
                .read<NotificationBloc>()
                .add(LoadNotification(notificationId: notification.id));
          }),
    );
  }
}
