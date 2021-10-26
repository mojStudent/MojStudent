abstract class NotificationEvent {}

class LoadNotifications extends NotificationEvent {}

class LoadNotification extends NotificationEvent {
  int notificationId;

  LoadNotification({required this.notificationId});
}

class SetNotificationAsRead extends NotificationEvent {
  int notificationId;
  
  SetNotificationAsRead({required this.notificationId});
}