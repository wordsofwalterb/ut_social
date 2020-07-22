import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ut_social/models/post.dart';
import 'package:ut_social/models/student.dart';
import 'package:ut_social/services/post_repository.dart';
import 'package:ut_social/services/user_repository.dart';

class Global {
  //static final FirebaseAnalytics analytics = FirebaseAnalytics();

  static final Map models = {
    Student: (Map<String, dynamic> data) => Student.fromMap(data),
    Post: (Map<String, dynamic> data) => Post.fromMap(data),
  };

  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  static final Map repository = {
    Post: () => FirebasePostRepository(),
    Student: () => UserRepository(),
  };

  static final CollectionReference likeRef =
      Firestore.instance.collection('likes');

  static final CollectionReference commentsRef =
      Firestore.instance.collection('comments');

  static final CollectionReference channelsRef =
      Firestore.instance.collection('channels');

  static final CollectionReference messagesRef =
      Firestore.instance.collection('messages');

  static final CollectionReference postsRef =
      Firestore.instance.collection('posts');

  static final CollectionReference studentsRef =
      Firestore.instance.collection('students');
}
