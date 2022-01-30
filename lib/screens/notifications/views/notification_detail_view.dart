import 'package:flutter_remix/flutter_remix.dart';
import 'package:html/dom.dart' as dom;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/constants/colors.dart';
import 'package:moj_student/data/auth/auth_repository.dart';
import 'package:moj_student/data/notifications/attachment_model.dart';
import 'package:moj_student/data/notifications/notification_repo.dart';
import 'package:moj_student/screens/widgets/data_containers/data_row_with_description.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/text_row_sliver.dart';
import 'package:moj_student/screens/widgets/data_containers/slivers/row_sliver.dart';
import 'package:moj_student/screens/widgets/modal.dart';
import 'package:moj_student/screens/widgets/screen_header.dart';
import 'package:moj_student/services/blocs/notification/notification_bloc.dart';
import 'package:moj_student/services/blocs/notification/notification_events.dart';
import 'package:moj_student/services/blocs/notification/notification_states.dart';
import 'package:moj_student/services/files/file_downloader.dart';
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
          backgroundColor: AppColors.ghostWhite,
          body: Column(
            children: _buildBody(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final notification =
        (context.read<NotificationBloc>().state as NotificationDetailLoaded)
            .notification;
    return [
      AppHeader(
        title:
            (context.read<NotificationBloc>().state as NotificationDetailLoaded)
                .notification
                .subject,
        onBackButtonClick: () => Future.delayed(Duration.zero, () {
          Navigator.of(context).pop("/notifications");
          context.read<NotificationBloc>().add(LoadNotifications());
        }),
      ),
      Expanded(
          child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverPadding(padding: EdgeInsets.only(top: 20)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: w * 0.03, vertical: h * 0.015),
              margin: EdgeInsets.symmetric(
                  horizontal: w * 0.06, vertical: h * 0.0075),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Html(
                  data: notification.body ?? '',
                  onLinkTap: (String? url, RenderContext context,
                      Map<String, String> attributes, dom.Element? element) {
                    if (url != null) {
                      canLaunch(url).then((can) {
                        if (can) launch(url);
                      });
                    }
                  }),
            ),
          ),
          TextRowSliver(
            data: notification.author ?? '',
            title: "Avtor",
            icon: FlutterRemix.user_3_line,
          ),
          TextRowSliver(
            data: notification.created ?? '',
            title: "Datum objave",
            icon: FlutterRemix.calendar_2_line,
          ),
          if (notification.attachments.isNotEmpty)
            RowSliver(
              title: "Priponke",
              icon: FlutterRemix.attachment_line,
              child: Column(
                children: [
                  for (var attachment in notification.attachments)
                    TextButton(
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
                ],
              ),
            ),
          SliverPadding(padding: EdgeInsets.only(top: 40)),
        ],
      ))
    ];
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
