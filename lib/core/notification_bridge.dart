import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/entities/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/core/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:ut_social/core/blocs/user_bloc/user_bloc.dart';

class NotificationBridge extends StatefulWidget {
  final Widget child;

  const NotificationBridge({this.child});
  @override
  _NotificationBridgeState createState() => _NotificationBridgeState();
}

class _NotificationBridgeState extends State<NotificationBridge> {
  final Firestore _db = Firestore.instance;
  UserBloc userBloc;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    final currentState = userBloc.state;
    if (currentState is UserAuthenticated) {
      // Get the current user
      String uid = currentState.currentUser.id;

      // Get the token for this device
      String fcmToken = await _fcm.getToken();

      // Save it to Firestore
      if (fcmToken != null) {
        final tokens = _db
            .collection('students')
            .document(uid)
            .collection('tokens')
            .document(fcmToken);

        await tokens.setData({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(), // optional
          'platform': Platform.operatingSystem // optional
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _saveDeviceToken();

    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessage: $message');
      FFNotification notification;

      if (Platform.isIOS) {
        notification = FFNotification.fromiOS(message, DateTime.now());
      } else if (Platform.isAndroid) {
        notification = FFNotification.fromAndroid(message, DateTime.now());
      }

      BlocProvider.of<NotificationsBloc>(context)
          .add(AddNotification(notification: notification));

      await showCupertinoDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(notification.title),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ));
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");

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
      print("onResume: $message");
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
