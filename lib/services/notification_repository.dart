import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/notification.dart';
import 'package:ut_social/util/globals.dart';

class FirebaseNotificationRepository {
  final Firestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirebaseNotificationRepository(
      {Firestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? Firestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> addNotificationToDb({
    FFNotification notification,
  }) async {
    final currentUser = await _firebaseAuth.currentUser();

    await Global.studentsRef
        .document(currentUser.uid)
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
    final currentUser = await _firebaseAuth.currentUser();

    final querySnapshot = await Global.studentsRef
        .document(currentUser.uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .limit(pageSize)
        .getDocuments();

    List<FFNotification> notifications = [];
    if (querySnapshot.documents.isNotEmpty) {
      notifications = querySnapshot.documents
          .map((e) => FFNotification.fromMap(
              e.data, (e.data['timestamp'] as Timestamp).toDate()))
          .toList();
    }

    return notifications;
  }

  Future<List<FFNotification>> fetchNextPage({
    @required DateTime startAfter,
    @required int pageSize,
  }) async {
    assert(startAfter != null);

    final currentUser = await _firebaseAuth.currentUser();

    final querySnapshot = await Global.studentsRef
        .document(currentUser.uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .startAfter([startAfter])
        .limit(pageSize)
        .getDocuments();

    final notifications = querySnapshot.documents
        .map((e) =>
            FFNotification.fromMap(e.data, e.data['timestamp'] as DateTime))
        .toList();

    return notifications;
  }
}
