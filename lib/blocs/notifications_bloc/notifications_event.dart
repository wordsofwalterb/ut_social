part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class LoadNotifications extends NotificationsEvent {
  final DateTime oldestTimestamp;

  const LoadNotifications({this.oldestTimestamp});

  @override
  List<Object> get props => [oldestTimestamp];
}

class BootstrapNotifications extends NotificationsEvent {
  @override
  List<Object> get props => [];
}

// class DeleteNotification extends NotificationsEvent {
//   final Notification notification;

//   const DeleteNotification({@required this.notification});

//   @override
//   List<Object> get props => [notification];
// }

class AddNotification extends NotificationsEvent {
  final FFNotification notification;

  const AddNotification({@required this.notification});

  @override
  List<Object> get props => [notification];
}

// class RefreshNotifications extends NotificationsEvent {
//   final DateTime mostRecentTimestamp;

//   const RefreshNotifications({this.mostRecentTimestamp});

//   @override
//   List<Object> get props => [mostRecentTimestamp];
// }
