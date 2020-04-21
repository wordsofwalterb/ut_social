import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/database_service.dart';

class Global {
  //static final FirebaseAnalytics analytics = FirebaseAnalytics();

  static final Map models = {
    Student: (data) => Student.fromMap(data),
    Post: (data) => Post.fromMap(data),
  };

  static final UserData<Student> currentUserRef =
      UserData<Student>(collection: 'students');

}
