part of 'notification_bloc.dart';

abstract class NotificationState extends BlocState {
  const NotificationState({
    super.statusCode,
    super.message,
    super.errorCode,
  });
}

class NotificationInitial extends NotificationState {}

class ListNotificationLoading extends NotificationState {}

class ListNotificationLoaded extends NotificationState {
  final List<NotificationDetail> notificationList;

  const ListNotificationLoaded(this.notificationList);
}

class ListNotificationEmpty extends NotificationState {}

class ListNotificationError extends NotificationState {
  final GenericErrorResponse errorResponse;

  const ListNotificationError(this.errorResponse);
}
