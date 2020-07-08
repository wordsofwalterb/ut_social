import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/core/entities/failure.dart';
import 'package:ut_social/core/entities/notification.dart';
import 'package:ut_social/core/repositories/notification_repository.dart';
import 'package:ut_social/notifications/notification_screen.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

// TODO: Error handing with error states
// TODO: Refresh and fetching latest
// TODO: Delete/dismiss notifications from Feed + Database
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final FirebaseNotificationRepository _repository;
  final int pageSize;

  NotificationsBloc(FirebaseNotificationRepository repository,
      {this.pageSize = 20})
      : _repository = repository;

  @override
  NotificationsState get initialState => NotificationsInitial();

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    final currentState = state;
    if (currentState is NotificationsInitial) {
      if (event is BootstrapNotifications) {
        yield* _bootstrapNotificationsToState(event);
      }
    } else if (currentState is NotificationsLoaded) {
      if (event is LoadNotifications) {
        yield* _loadNotificationsToState(event);
      }
      if (event is AddNotification) {
        yield* _addNotificationToState(event);
      }
      if (event is BootstrapNotifications) {
        yield* _bootstrapNotificationsToState(event);
      }
      // if (event is DeleteNotification) {
      //   yield* _deleteNotificationToState(event);
      // }
      // if (event is RefreshNotifications) {
      //   yield* _refreshNotificationsToState(event);
      // }
    } else if (currentState is NotificationsReachedMax) {
      if (event is AddNotification) {
        yield* _addNotificationToState(event);
      }
      if (event is BootstrapNotifications) {
        yield* _bootstrapNotificationsToState(event);
      }
      // if (event is DeleteNotification) {
      //   yield* _deleteNotificationToState(event);
      // }
      // if (event is RefreshNotifications) {
      //   yield* _refreshNotificationsToState(event);
      // }
    } else if (currentState is NotificationsError) {
      if (event is BootstrapNotifications) {
        yield* _bootstrapNotificationsToState(event);
      }
    }
  }

  Stream<NotificationsState> _bootstrapNotificationsToState(
      BootstrapNotifications event) async* {
    final notifications = await _repository.initialNotifications(
      pageSize: pageSize,
    );

    if (notifications.length < pageSize) {
      yield NotificationsReachedMax(notifications: notifications);
    } else {
      yield NotificationsLoaded(notifications: notifications);
    }
  }

  Stream<NotificationsState> _addNotificationToState(
      AddNotification event) async* {
    final currentState = state;
    List<FFNotification> updatedNotifications = [];

    if (currentState is NotificationsReachedMax) {
      updatedNotifications.addAll(currentState.notifications);
    } else if (currentState is NotificationsLoaded) {
      updatedNotifications.addAll(currentState.notifications);
    }

    updatedNotifications.insert(0, event.notification);

    if (updatedNotifications.length < pageSize) {
      yield NotificationsReachedMax(notifications: updatedNotifications);
    } else {
      yield NotificationsLoaded(notifications: updatedNotifications);
    }
  }

  // Stream<NotificationsState> _deleteNotificationToState(
  //     DeleteNotification event) async* {
  //   final currentState = state;
  //   List<Notification> updatedNotifications = [];

  //   if (currentState is NotificationsReachedMax) {
  //     updatedNotifications.addAll(currentState.notifications);
  //   } else if (currentState is NotificationsLoaded) {
  //     updatedNotifications.addAll(currentState.notifications);
  //   }

  //   updatedNotifications.remove(event.notification);

  //   if (currentState is NotificationsReachedMax) {
  //     yield NotificationsReachedMax(notifications: updatedNotifications);
  //   } else {
  //     yield NotificationsLoaded(notifications: updatedNotifications);
  //   }
  // }

  Stream<NotificationsState> _loadNotificationsToState(
      LoadNotifications event) async* {
    final currentState = state;
    List<FFNotification> updatedNotifications = [];

    if (currentState is NotificationsLoaded) {
      updatedNotifications.addAll(currentState.notifications);
    }

    final retrievedNotifications = await _repository.fetchNextPage(
      startAfter: event.oldestTimestamp,
      pageSize: pageSize,
    );

    updatedNotifications.addAll(retrievedNotifications);

    if (retrievedNotifications.length < pageSize) {
      yield NotificationsReachedMax(notifications: updatedNotifications);
    } else {
      yield NotificationsLoaded(notifications: updatedNotifications);
    }
  }

  // Stream<NotificationsState> _refreshNotificationsToState(
  //     RefreshNotifications event) async* {
  //   final currentState = state;
  //   List<Notification> updatedNotifications = [];

  //   if (currentState is NotificationsLoaded) {
  //     updatedNotifications.addAll(currentState.notifications);
  //   }

  //   final retrievedNotifications = await _repository.fetch(
  //     startBefore: event.mostRecentTimestamp,
  //     pageSize: pageSize,
  //   );

  //   updatedNotifications.addAll(retrievedNotifications);

  //   if (retrievedNotifications.length < pageSize) {
  //     yield NotificationsReachedMax(notifications: updatedNotifications);
  //   } else {
  //     yield NotificationsLoaded(notifications: updatedNotifications);
  //   }
  // }
}
