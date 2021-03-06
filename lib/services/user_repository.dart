import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/student.dart';
import 'package:ut_social/services/post_upload_repository.dart';
import 'package:ut_social/util/globals.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseAuth firebaseAuth, FirebaseFirestore firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUp({
    String email,
    String password,
    String firstName,
    String lastName,
  }) async {
    try {
      final UserCredential result =
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

    final _random = Random();

    final defaultAvatarIndex = _random.nextInt(4);
    const accessToken = [
      'https://firebasestorage.googleapis.com/v0/b/fyrefly-92a36.appspot.com/o/images%2Fdefault%2FdefaultAvatar1.png?alt=media&token=4f1a8bd3-39f7-4f72-b26a-417afa58d1a0',
      'https://firebasestorage.googleapis.com/v0/b/fyrefly-92a36.appspot.com/o/images%2Fdefault%2FdefaultAvatar2.png?alt=media&token=61f44679-6903-46bf-b806-7cdc819d3ace',
      'https://firebasestorage.googleapis.com/v0/b/fyrefly-92a36.appspot.com/o/images%2Fdefault%2FdefaultAvatar3.png?alt=media&token=aa2ccebb-d34c-4c55-814f-54934d41a590',
      'https://firebasestorage.googleapis.com/v0/b/fyrefly-92a36.appspot.com/o/images%2Fdefault%2FdefaultAvatar4.png?alt=media&token=c6ee020c-4d0d-4f30-97ed-dd4fdcc93401',
    ];

    try {
      final currentUser = _firebaseAuth.currentUser;
      print('setting up profile $firstName');
      await Global.studentsRef.doc(currentUser.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'fullName': '$firstName $lastName',
        'avatarUrl': accessToken[defaultAvatarIndex],
      });
      print('done setting up profile $firstName');
    } catch (error) {
      print('Unable to setup user: $error');
      throw ('There was an unexpected error connecting to the database');
    }
  }

  Future<void> updateUser(Student updatedUser) async {
    final User currentUser = _firebaseAuth.currentUser;
    await Global.studentsRef
        .doc(currentUser.uid)
        .set(updatedUser.toJson(), SetOptions(merge: true));
  }

  Future<bool> isSignedIn() async {
    final User currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<Student> getUser() async {
    final User currentUser = _firebaseAuth.currentUser;
    final DocumentSnapshot userDoc =
        await Global.studentsRef.doc(currentUser.uid).get();

    return Student.fromJson(
      userDoc.data()
        ..addAll(
          <String, dynamic>{'id': userDoc.id},
        ),
    );
  }

  Future<String> uploadAvatar(File imageFile) async {
    final User currentUser = _firebaseAuth.currentUser;
    final DocumentSnapshot userDoc =
        await Global.studentsRef.document(currentUser.uid).get();

    final imageUrl = StorageService.uploadUserProfileImage(
        userDoc.data()['avatarUrl'] as String, imageFile);

    await Global.studentsRef
        .doc(currentUser.uid)
        .set({'avatarUrl': imageUrl}, SetOptions(merge: true));

    return imageUrl;
  }
}
