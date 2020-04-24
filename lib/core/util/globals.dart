import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/repositories/user_repository.dart';
import 'package:ut_social/core/util/database_service.dart';
import 'package:ut_social/feed/post_repository.dart';

class Global {
  //static final FirebaseAnalytics analytics = FirebaseAnalytics();

  static final Map models = {
    Student: (data) => Student.fromMap(data),
    Post: (data) => Post.fromMap(data),
  };

  static final Map repository = {
    Post: () => FirebasePostRepository(),
    Student: () => UserRepository(),
  };

  static final UserData<Student> currentUserRef =
      UserData<Student>(collection: 'students');

  static final likeRef = Firestore.instance.collection('likes');
  static final commentsRef = Firestore.instance.collection('comments');
  static final postsRef = Firestore.instance.collection('posts');
  static final studentsRef = Firestore.instance.collection('students');
}
