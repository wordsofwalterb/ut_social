part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  @override
  List<Object> get props => [];
}

class NotificationsLoaded extends NotificationsState {
  final List<FFNotification> notifications;

  const NotificationsLoaded({@required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationsReachedMax extends NotificationsState {
  final List<FFNotification> notifications;

  const NotificationsReachedMax({@required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationsError extends NotificationsState {
  final List<FFNotification> notifications;
  final Failure error;

  const NotificationsError({
    @required this.notifications,
    @required this.error,
  });

  @override
  List<Object> get props => [notifications, error];
}
