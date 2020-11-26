import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:ut_social/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';

import 'package:ut_social/util/globals.dart';
import '../models/notification.dart';

class NotificationBridge extends StatefulWidget {
  final Widget child;

  const NotificationBridge({this.child});
  @override
  _NotificationBridgeState createState() => _NotificationBridgeState();
}

class _NotificationBridgeState extends State<NotificationBridge> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  UserBloc userBloc;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    final currentState = userBloc.state;
    if (currentState is UserAuthenticated) {
      // Get the current user
      final String uid = currentState.currentUser.id;

      // Get the token for this device
      final String fcmToken = await _fcm.getToken();

      // Save it to Firestore
      if (fcmToken != null) {
        final userRef = _db.collection('students').doc(uid);

        await userRef.set({
          'notificationToken': fcmToken,
          'notificationsEnabled': true,
        }, SetOptions(merge: true));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    final currentState = userBloc.state;

    if (currentState is UserAuthenticated) {
      if (Platform.isIOS) {
        iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
          // save the token  OR subscribe to a topic here
          if (data.alert) {
            _saveDeviceToken();
          } else {
            Global.studentsRef.document(currentState.currentUser.id).set(
              {'notificationsEnabled': false},
              SetOptions(merge: true),
            );
          }
        });

        _fcm.requestNotificationPermissions(const IosNotificationSettings());
      } else {
        if (currentState.currentUser.notificationsEnabled ?? true) {
          _saveDeviceToken();
        }
      }
    }

    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      FFNotification notification;

      if (Platform.isIOS) {
        notification = FFNotification.fromiOS(message, DateTime.now());
      } else if (Platform.isAndroid) {
        notification = FFNotification.fromAndroid(message, DateTime.now());
      }

      BlocProvider.of<NotificationsBloc>(context).add(
        AddNotification(notification: notification),
      );

      showSimpleNotification(
        Text(
          notification.body,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        background: Theme.of(context).backgroundColor,
      );
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch: $message');

      FFNotification notification;

      if (Platform.isIOS) {
        notification = FFNotification.fromiOS(message, DateTime.now());
      } else if (Platform.isAndroid) {
        notification = FFNotification.fromAndroid(message, DateTime.now());
      }

      BlocProvider.of<NotificationsBloc>(context)
          .add(AddNotification(notification: notification));

      // TODO optional
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume: $message');
      // TODO optional

      FFNotification notification;

      if (Platform.isIOS) {
        notification = FFNotification.fromiOS(message, DateTime.now());
      } else if (Platform.isAndroid) {
        notification = FFNotification.fromAndroid(message, DateTime.now());
      }

      BlocProvider.of<NotificationsBloc>(context)
          .add(AddNotification(notification: notification));
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
