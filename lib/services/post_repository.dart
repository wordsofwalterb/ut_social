import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/post.dart';
import 'package:ut_social/models/student.dart';
import 'package:ut_social/util/globals.dart';

abstract class PostRepository {
  Future<List<Post>> fetchNextPage({@required DateTime startAfter, int limit});
  Future<List<Post>> setupPosts();
  Future<Post> addPost(Student author, String body, String imageUrl);
  Future<void> unlikePost(String postId);
  Future<void> likePost(String postId);
  Future<void> deletePost(String postId);
  Future<void> updateCommentCount(String postId, int byValue);
}

class FirebasePostRepository extends PostRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirebasePostRepository(
      {FirebaseFirestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<List<Post>> setupPosts() async {
    final newDocumentList = await _firestore
        .collection('posts')
        .orderBy('postTime', descending: true)
        .limit(20)
        .get();

    final currentUser = _firebaseAuth.currentUser;
    final List<Post> newPosts = newDocumentList.docs
        .map((v) => Post.fromJson(
              v.data()
                ..addAll({
                  'id': v.id,
                  'likedByUser':
                      (v.data()['likedBy'] as List).contains(currentUser.uid),
                })
                ..update('postTime',
                    (value) => (value as Timestamp).toDate().toString()),
            ))
        .toList();

    final List<Post> updatedPosts = [];

    for (final post in newPosts) {
      updatedPosts.add(await _getAuthorInfoWithPost(post));
    }

    return updatedPosts;
  }

  Future<Post> _getAuthorInfoWithPost(Post post) async {
    final doc =
        await _firestore.collection('students').doc(post.authorId).get();

    return post.copyWith(
        authorName: doc.data()['fullName'] as String,
        avatarUrl: doc.data()['avatarUrl'] as String);
  }

  @override
  Future<void> deletePost(String postId) async {
    assert(postId != null);

    await Global.postsRef.doc(postId).delete();
  }

  @override
  Future<List<Post>> fetchNextPage({
    @required DateTime startAfter,
    int limit = 20,
  }) async {
    assert(startAfter != null);

    final newDocumentList = await _firestore
        .collection('posts')
        .orderBy('postTime', descending: true)
        .startAfter([startAfter])
        .limit(limit)
        .get();

    final currentUser = _firebaseAuth.currentUser;
    final newPosts = newDocumentList.docs
        .map((DocumentSnapshot v) => Post.fromJson(
              v.data()
                ..addAll({
                  'id': v.id,
                  'likedByUser':
                      (v.data()['likedBy'] as List).contains(currentUser.uid)
                })
                ..update('postTime',
                    (value) => (value as Timestamp).toDate().toString()),
            ))
        .toList();

    final List<Post> updatedPosts = [];

    for (final post in newPosts) {
      updatedPosts.add(await _getAuthorInfoWithPost(post));
    }

    return updatedPosts;
  }

  @override
  Future<Post> addPost(Student author, String body, String imageUrl) async {
    assert(author != null);
    assert(body != null);

    final DateTime timestamp = DateTime.now();

    final docRef = await Global.postsRef.add({
      'authorId': author.id,
      'authorName': author.fullName,
      'postTime': timestamp,
      'imageUrl': imageUrl,
      'body': body,
      'avatarUrl': author.avatarUrl,
      'likeCount': 0,
      'likedBy': const <String>[],
      'commentCount': 0,
    });
    assert(docRef.id != null);

    return Post(
        id: docRef.id,
        authorId: author.id,
        avatarUrl: author.avatarUrl,
        authorName: author.fullName,
        body: body,
        postTime: timestamp,
        likeCount: 0,
        likedBy: const <String>[],
        commentCount: 0);
  }

// TODO: ALL THESE NEEED TO HANDLE AND ADAPT TO SITUATIONS WHERE POST WAS
// Deleted by another user and will be unable to update properly
  @override
  Future<void> unlikePost(String postId) async {
    final currentUser = _firebaseAuth.currentUser;
    await Global.postsRef.doc(postId).update({
      'likeCount': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([currentUser.uid]),
    });

    // Needed so double notifications are not sent
    await Global.postsRef.doc(postId).update({
      'unlikedBy': FieldValue.arrayUnion([currentUser.uid])
    });
  }

  @override
  Future<void> likePost(String postId) async {
    final currentUser = _firebaseAuth.currentUser;
    await Global.postsRef.doc(postId).update({
      'likeCount': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([currentUser.uid]),
    });
  }

  @override
  Future<void> updateCommentCount(String postId, int byValue) async {
    await Global.postsRef.doc(postId).update({
      'commentCount': FieldValue.increment(byValue),
    });
  }
}
