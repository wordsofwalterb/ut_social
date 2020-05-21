import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/globals.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  UserRepository({FirebaseAuth firebaseAuth, Firestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? Firestore.instance;

  Future<AuthResult> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResult> signUp({
    String email,
    String password,
    String firstName,
    String lastName,
  }) async {
    try {
      final AuthResult result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await setupUser(firstName: firstName, lastName: lastName, email: email);
      return result;
    } catch (error) {
      rethrow;
    }
  }

  /// Signs the current user out
  Future<void> signOut() async {
    return Future.wait(<Future<dynamic>>[
      _firebaseAuth.signOut(),
    ]);
  }

  /// Creates document for user in firestore after registration.
  ///
  /// [firstName], [lastName], and [email], must not be
  /// null.
  Future<void> setupUser(
      {@required String firstName,
      @required String lastName,
      @required String email}) async {
    assert(firstName != null);
    assert(lastName != null);
    assert(email != null);

    try {
      final currentUser = await _firebaseAuth.currentUser();

      await Global.studentsRef.document(currentUser.uid).setData({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'fullName': '$firstName $lastName',
      });
    } catch (error) {
      print('Unable to setup user: $error');
    }
  }

  Future<bool> isSignedIn() async {
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<Student> getUser() async {
    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    final DocumentSnapshot userDoc =
        await Global.studentsRef.document(currentUser.uid).get();
    return Student.fromMap(
      userDoc.data
        ..addAll(
          <String, dynamic>{'id': userDoc.documentID},
        ),
    );
  }
}
