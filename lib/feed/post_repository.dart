import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/util/globals.dart';

abstract class PostRepository {
  Future<List<Post>> fetchNextPage({DateTime startAfter, int limit});
  Future<List<Post>> setupFeed();
  Future<void> unlikePost(String postId);
  Future<void> likePost(String postId);
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

  @override
  Future<List<Post>> fetchNextPage(
      {@required DateTime startAfter, int limit = 20}) async {
    assert(startAfter != null);

    var newDocumentList = await _firestore
        .collection("posts")
        .orderBy("postTime", descending: true)
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

  Future<void> unlikePost(String postId) async {
    await Global.postsRef.document(postId).updateData({
      'likeCount': FieldValue.increment(-1),
    });
  }

  Future<void> likePost(String postId) async {
    await Global.postsRef.document(postId).updateData({
      'likeCount': FieldValue.increment(1),
    });
  }
}
