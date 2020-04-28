import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/globals.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

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

  Future<void> signOut() async {
    return Future.wait(<Future<dynamic>>[
      _firebaseAuth.signOut(),
    ]);
  }

  Future<void> setupUser(
      {String firstName, String lastName, String email}) async {
    try {
      await Global.currentUserRef.upsert(<String, dynamic>{
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (email != null) 'email': email,
        if (firstName != null && lastName != null)
          'fullName': '$firstName $lastName',
        'avatarUrl': '',
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
