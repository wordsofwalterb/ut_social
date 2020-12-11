import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/notification.dart';
import 'package:ut_social/util/globals.dart';

class FirebaseNotificationRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirebaseNotificationRepository(
      {FirebaseFirestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> addNotificationToDb({
    FFNotification notification,
  }) async {
    final currentUser = _firebaseAuth.currentUser;

    await Global.studentsRef
        .doc(currentUser.uid)
        .collection('notifications')
        .add(notification.toMap());
  }

  // Future<void> removeNotificationFromDb({
  //   Notification notification,
  // }) async {
  //   final currentUser = await _firebaseAuth.currentUser();

  //   await Global.studentsRef
  //       .document(currentUser.uid)
  //       .collection('notifications')
  //       .document(notification.toMap());
  // }

  Future<List<FFNotification>> initialNotifications({
    @required int pageSize,
  }) async {
    final currentUser = _firebaseAuth.currentUser;

    final querySnapshot = await Global.studentsRef
        .doc(currentUser.uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .limit(pageSize)
        .get();

    List<FFNotification> notifications = [];
    if (querySnapshot.docs.isNotEmpty) {
      notifications = querySnapshot.docs
          .map((e) => FFNotification.fromMap(
              e.data(), (e.data()['timestamp'] as Timestamp).toDate()))
          .toList();
    }

    return notifications;
  }

  Future<List<FFNotification>> fetchNextPage({
    @required DateTime startAfter,
    @required int pageSize,
  }) async {
    assert(startAfter != null);

    final currentUser = _firebaseAuth.currentUser;

    final querySnapshot = await Global.studentsRef
        .doc(currentUser.uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .startAfter([startAfter])
        .limit(pageSize)
        .get();

    final notifications = querySnapshot.documents
        .map((e) =>
            FFNotification.fromMap(e.data(), e.data()['timestamp'] as DateTime))
        .toList();

    return notifications;
  }
}
