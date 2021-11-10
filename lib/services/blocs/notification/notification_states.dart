import 'package:moj_student/data/notifications/notification_model.dart';

abstract class NotificationState {
  const NotificationState();
}

class InitialNotificationState extends NotificationState {}

class NotificationsLoading extends NotificationState {
}

class NotificationsLoaded extends NotificationState {
  List<NotificationModel> notifications;

  NotificationsLoaded({required this.notifications});
}

class NotificationDetailLoading extends NotificationState {}


class NotificationDetailLoaded extends NotificationState {
  NotificationModel notification;

  NotificationDetailLoaded({required this.notification});
}

class DataLoading extends NotificationState {}

class DataLoadingError extends NotificationState {
  Object e;

  DataLoadingError({required this.e}) {
    e = e;
  }
}