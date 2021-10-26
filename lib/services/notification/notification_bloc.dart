import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moj_student/data/notifications/notification_repo.dart';
import 'package:moj_student/services/notification/notification_events.dart';
import 'package:moj_student/services/notification/notification_states.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepo notificationRepo;

  NotificationBloc({required this.notificationRepo})
      : super(InitialNotificationState()) {
    on<LoadNotifications>(_onNotificationsLoad);
    on<LoadNotification>(_onNotificationLoad);
    on<SetNotificationAsRead>(_onNotificationSetAsRead);
  }

  Future<void> _onNotificationsLoad(
      LoadNotifications event, Emitter emit) async {
    emit(DataLoading());

    try {
      final notifications = await notificationRepo.getNotifications();
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(DataLoadingError(e: e));
    }
  }

  Future<void> _onNotificationLoad(LoadNotification event, Emitter emit) async {
    emit(DataLoading());

    try {
      final notification = await notificationRepo.getNotification(
          notificationId: event.notificationId);
      emit(NotificationDetailLoaded(notification: notification));
    } catch (e) {
      emit(DataLoadingError(e: e));
    }
  }

  Future<void> _onNotificationSetAsRead(
      SetNotificationAsRead event, Emitter emit) async {
    emit(DataLoading());

    try {
      await notificationRepo.getNotification(
          notificationId: event.notificationId);
      final notifications = await notificationRepo.getNotifications();
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(DataLoadingError(e: e));
    }
  }
}
