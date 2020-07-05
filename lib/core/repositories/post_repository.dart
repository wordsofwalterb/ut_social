import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/globals.dart';

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
  final Firestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirebasePostRepository({Firestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? Firestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<List<Post>> setupPosts() async {
    final newDocumentList = await _firestore
        .collection('posts')
        .orderBy('postTime', descending: true)
        .limit(20)
        .getDocuments();

    final currentUser = await _firebaseAuth.currentUser();
    List<Post> newPosts = newDocumentList.documents
        .map((v) => Post.fromMap(
              v.data
                ..addAll({
                  'id': v.documentID,
                  'isLikedByUser':
                      (v.data['likedBy'] as List).contains(currentUser.uid),
                }),
            ))
        .toList();

    List<Post> updatedPosts = [];

    for (final post in newPosts) {
      updatedPosts.add(await _getAuthorInfoWithPost(post));
    }

    return updatedPosts;
  }

  Future<Post> _getAuthorInfoWithPost(Post post) async {
    final doc =
        await _firestore.collection('students').document(post.authorId).get();

    return post.copyWith(
        authorName: doc.data['fullName'] as String,
        avatarUrl: doc.data['avatarUrl'] as String);
  }

  @override
  Future<void> deletePost(String postId) async {
    assert(postId != null);

    await Global.postsRef.document(postId).delete();
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
        .getDocuments();

    final currentUser = await _firebaseAuth.currentUser();
    final newPosts = newDocumentList.documents
        .map((DocumentSnapshot v) => Post.fromMap(
              v.data
                ..addAll({
                  'id': v.documentID,
                  'isLikedByUser':
                      (v.data['likedBy'] as List).contains(currentUser.uid)
                }),
            ))
        .toList();

    List<Post> updatedPosts = [];

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
    assert(docRef.documentID != null);

    return Post(
        id: docRef.documentID,
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
    final currentUser = await _firebaseAuth.currentUser();
    await Global.postsRef.document(postId).updateData({
      'likeCount': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([currentUser.uid])
    });
  }

  @override
  Future<void> likePost(String postId) async {
    final currentUser = await _firebaseAuth.currentUser();
    await Global.postsRef.document(postId).updateData({
      'likeCount': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([currentUser.uid])
    });
  }

  @override
  Future<void> updateCommentCount(String postId, int byValue) async {
    await Global.postsRef.document(postId).updateData({
      'commentCount': FieldValue.increment(byValue),
    });
  }
}
