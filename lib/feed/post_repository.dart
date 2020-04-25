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
}

class FirebasePostRepository extends PostRepository {
  final Firestore _firestore;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  FirebasePostRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Future<List<Post>> setupFeed() async {
    var newDocumentList = await _firestore
        .collection("posts")
        .orderBy("postTime", descending: true)
        .limit(10)
        .getDocuments();

    var newPosts = newDocumentList.documents
        .map(
          (v) => Post.fromMap(
            v.data..addAll({'id': v.documentID}),
          ),
        )
        .toList();

    return newPosts;
  }

  Future<Post> addPost(Student author, String body, String imageUrl) async {
    assert(author != null);
    assert(body != null);

    final timestamp = DateTime.now();

    var docRef = await Global.postsRef.add({
      'authorId': author.id,
      'authorName': author.fullName,
      'postTime': timestamp,
      'imageUrl': imageUrl,
      'body': body,
      'avatarUrl': author.avatarUrl,
      'likeCount': 0,
      'likedBy': [],
      'commentCount': 0,
    });

    assert(docRef.documentID != null);

    return Post(
        postId: docRef.documentID,
        authorId: author.id,
        avatarUrl: author.avatarUrl,
        authorName: author.fullName,
        body: body,
        postTime: timestamp,
        likeCount: 0,
        likedBy: [],
        commentCount: 0);
  }

  Future<List<Post>> retrieveLatestPosts(DateTime startBefore) async {
    var newDocumentList = await _firestore
        .collection("posts")
        .orderBy("postTime", descending: false)
        .startAfter([startBefore]).getDocuments();

    var newPosts = newDocumentList.documents
        .map(
          (v) => Post.fromMap(
            v.data..addAll({'id': v.documentID}),
          ),
        )
        .toList();

    return newPosts;
  }

  @override
  Future<List<Post>> fetchNextPage(
      {@required DateTime startAfter, int limit = 20}) async {
    assert(startAfter != null);

    var newDocumentList = await _firestore
        .collection("posts")
        .orderBy("postTime", descending: true)
        .where('postTime', isLessThan: startAfter)
        .startAfter([startAfter])
        .limit(limit)
        .getDocuments();

    var newPosts = newDocumentList.documents
        .map(
          (v) => Post.fromMap(
            v.data..addAll({'id': v.documentID}),
          ),
        )
        .toList();

    return newPosts;
  }

  Future<void> unlikePost(String postId, String userId) async {
    Global.postsRef.document(postId).updateData({
      'likeCount': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  Future<void> likePost(String postId, String userId) async {
    await Global.postsRef.document(postId).updateData({
      'likeCount': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }
}
