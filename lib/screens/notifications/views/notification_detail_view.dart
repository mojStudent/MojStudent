import 'package:html/dom.dart' as dom;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/notifications/attachment_model.dart';
import 'package:moj_student/data/notifications/notification_repo.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/services/files/file_downloader.dart';
import 'package:moj_student/services/notification/notification_bloc.dart';
import 'package:moj_student/services/notification/notification_events.dart';
import 'package:moj_student/services/notification/notification_states.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDetailView extends StatelessWidget {
  const NotificationDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationBloc(notificationRepo: context.read<NotificationRepo>()),
      child: WillPopScope(
        onWillPop: () async {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).pop("/notifications");
            context.read<NotificationBloc>().add(LoadNotifications());
          });
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColors.green,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            backgroundColor: AppColors.raisinBlack[500],
            elevation: 0,
            title: Text("Obvestilo"),
            centerTitle: true,
          ),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final notification =
        (context.read<NotificationBloc>().state as NotificationDetailLoaded)
            .notification;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: CustomScrollView(
            slivers: [
              SliverPadding(padding: EdgeInsets.only(top: 20)),
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    notification.subject,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black54,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          notification.author ?? '',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.black54,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      notification.created ?? '',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Flexible(
                  child: Html(
                      data: notification.body ?? '',
                      onLinkTap: (String? url,
                          RenderContext context,
                          Map<String, String> attributes,
                          dom.Element? element) {
                        if (url != null) {
                          canLaunch(url).then((can) {
                            if (can) launch(url);
                          });
                        }
                      }),
                ),
              ),
              SliverPadding(padding: EdgeInsets.only(top: 10)),
              SliverToBoxAdapter(
                child: Divider(
                  color: Colors.black,
                ),
              ),
              if (notification.attachments.isNotEmpty)
                SliverToBoxAdapter(
                  child: Text(
                    "Priponke",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
              for (var attachment in notification.attachments)
                SliverToBoxAdapter(
                  child: TextButton(
                    onPressed: () async =>
                        await _onAttachmentDownloadButtonPressed(
                            attachment, context),
                    child: Row(
                      children: [
                        Icon(Icons.file_download),
                        Flexible(child: Text(attachment.label))
                      ],
                    ),
                  ),
                ),
              if (notification.attachments.isNotEmpty)
                SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              SliverPadding(padding: EdgeInsets.only(top: 40)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAttachmentDownloadButtonPressed(
      AttachmentModel attachment, BuildContext context) async {
    var authRepo = AuthRepository();
    var bearer = "Bearer ${authRepo.token}";
    var url = 'https://student.sd-lj.si/api/attachment/${attachment.path}';

    try {
      BottomModal.showFileDownloading(context);
      await FileDownloader.openFileFromUrl(
          url: url, bearer: bearer, getFilenameFromHeader: true);
      Navigator.pop(context);
    } on FileDownloaderException catch (e) {
      _showSnackbarWithText(e.message, context);
    }
  }

  void _showSnackbarWithText(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
