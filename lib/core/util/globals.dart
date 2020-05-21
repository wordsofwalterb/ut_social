import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/repositories/user_repository.dart';
import 'package:ut_social/feed/post_repository.dart';

class Global {
  //static final FirebaseAnalytics analytics = FirebaseAnalytics();

  static final Map models = {
    Student: (Map<String, dynamic> data) => Student.fromMap(data),
    Post: (Map<String, dynamic> data) => Post.fromMap(data),
  };

  static final Map repository = {
    Post: () => FirebasePostRepository(),
    Student: () => UserRepository(),
  };

  static final CollectionReference likeRef =
      Firestore.instance.collection('likes');

  static final CollectionReference commentsRef =
      Firestore.instance.collection('comments');

  static final CollectionReference postsRef =
      Firestore.instance.collection('posts');

  static final CollectionReference studentsRef =
      Firestore.instance.collection('students');
}
