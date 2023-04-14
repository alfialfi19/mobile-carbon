part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {}

class LoadNotification extends NotificationEvent {
  final String? status;

  LoadNotification({
    this.status,
  });

  @override
  List<Object?> get props => [
        status,
      ];
}

class LoadDetailNotification extends NotificationEvent {
  final String? id;

  LoadDetailNotification({
    this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
