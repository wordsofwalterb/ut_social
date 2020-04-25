import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/globals.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore = Firestore.instance;

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
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
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
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<void> setupUser(
      {String firstName, String lastName, String email}) async {
    try {
      await Global.currentUserRef.upsert({
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (email != null) 'email': email,
        if (firstName != null && lastName != null)
          'fullName': firstName + ' ' + lastName,
        'likedPosts': [],
        'avatarUrl':  '',
        'likedComments': [],
      });
    } catch (error) {
      print('Unable to setup user: $error');
    }
  }

  Future<void> likePost(String postId, String userId) async {
    await Global.studentsRef.document(userId).setData({
      'likedPosts': FieldValue.arrayUnion([postId]),
    }, merge: true);

    // await Global.postsRef
    //     .document(postId)
    //     .updateData({'likeCount': FieldValue.increment(1)});
  }

  Future<void> dislikePost(String postId, String userId) async {
    await Global.studentsRef.document(userId).setData({
      'likedPosts': FieldValue.arrayRemove([postId]),
    }, merge: true);

    // await Global.postsRef.document(postId).updateData({
    //   'likeCount': FieldValue.increment(-1),
    // });
  }

  Future<void> dislikeComment(String commentId, String userId) async {
    await Global.studentsRef.document(userId).setData({
      'likedPosts': FieldValue.arrayRemove([commentId]),
    }, merge: true);

    await Global.postsRef.document(commentId).updateData({
      'likeCount': FieldValue.increment(-1),
    });
  }

  Future<void> likeComment(String commentId, String userId) async {
    await Global.studentsRef.document(userId).setData({
      'likedPosts': FieldValue.arrayUnion([commentId]),
    }, merge: true);

    await Global.postsRef.document(commentId).updateData({
      'likeCount': FieldValue.increment(1),
    });
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<Student> getUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    var userDoc = await Global.studentsRef.document(currentUser.uid).get();
    return Student.fromMap(userDoc.data..addAll({'id': userDoc.documentID}));
  }
}
