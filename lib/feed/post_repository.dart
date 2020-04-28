import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/globals.dart';

abstract class PostRepository {
  Future<List<Post>> fetchNextPage({DateTime startAfter, int limit});
  Future<List<Post>> setupFeed();
  Future<void> unlikePost(String postId, String userId);
  Future<void> likePost(String postId, String userId);
  Future<List<Post>> retrieveLatestPosts(DateTime startBefore);
  Future<Post> addPost(Student author, String body, String imageUrl);
  Future<void> updateCommentCount(String postId, int byValue);
}

class FirebasePostRepository extends PostRepository {
  final Firestore _firestore;

  FirebasePostRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Future<List<Post>> setupFeed() async {
    final QuerySnapshot newDocumentList = await _firestore
        .collection('posts')
        .orderBy('postTime', descending: true)
        .limit(10)
        .getDocuments();

    final List<Post> newPosts = newDocumentList.documents
        .map(
          (DocumentSnapshot v) => Post.fromMap(
            v.data..addAll(<String, dynamic>{'id': v.documentID}),
          ),
        )
        .toList();

    return newPosts;
  }

  @override
  Future<Post> addPost(Student author, String body, String imageUrl) async {
    assert(author != null);
    assert(body != null);

    final DateTime timestamp = DateTime.now();

    final DocumentReference docRef =
        await Global.postsRef.add(<String, dynamic>{
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

  @override
  Future<List<Post>> retrieveLatestPosts(DateTime startBefore) async {
    final QuerySnapshot newDocumentList = await _firestore
        .collection('posts')
        .orderBy('postTime', descending: true)
        .limit(20)
        .startAfter(<DateTime>[startBefore]).getDocuments();

    final List<Post> newPosts = newDocumentList.documents
        .map(
          (DocumentSnapshot v) => Post.fromMap(
            v.data..addAll(<String, dynamic>{'id': v.documentID}),
          ),
        )
        .toList();

    return newPosts;
  }

  @override
  Future<List<Post>> fetchNextPage(
      {@required DateTime startAfter, int limit = 20}) async {
    assert(startAfter != null);

    final QuerySnapshot newDocumentList = await _firestore
        .collection('posts')
        .orderBy('postTime', descending: true)
        .where('postTime', isLessThan: startAfter)
        .startAfter(<DateTime>[startAfter])
        .limit(limit)
        .getDocuments();

    final List<Post> newPosts = newDocumentList.documents
        .map(
          (DocumentSnapshot v) => Post.fromMap(
            v.data..addAll(<String, dynamic>{'id': v.documentID}),
          ),
        )
        .toList();

    return newPosts;
  }

// TODO: ALL THESE NEEED TO HANDLE AND ADAPT TO SITUATIONS WHERE POST WAS
// Deleted by another user and will be unable to update properly
  @override
  Future<void> updateCommentCount(String postId, int byValue) async {
    await Global.postsRef.document(postId).updateData({
      'commentCount': FieldValue.increment(byValue),
    });
  }

  @override
  Future<void> unlikePost(String postId, String userId) async {
    await Global.postsRef.document(postId).updateData(<String, dynamic>{
      'likeCount': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove(<String>[userId]),
    });
  }

  @override
  Future<void> likePost(String postId, String userId) async {
    await Global.postsRef.document(postId).updateData(<String, dynamic>{
      'likeCount': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion(<String>[userId]),
    });
  }
}
