import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchNextPage({DateTime startAfter, int limit});
  Future<List<Comment>> setupFeed();
}

class FirebaseCommentRepository extends CommentRepository {
  final Firestore _firestore;

  FirebaseCommentRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Future<List<Comment>> setupFeed() async {
    var newDocumentList = await _firestore
        .collection("comments")
        .orderBy("timestamp", descending: true)
        .limit(10)
        .getDocuments();

    var newComments = newDocumentList.documents
        .map(
          (v) => Comment.fromMap(
            v.data..addAll({'id': v.documentID}),
          ),
        )
        .toList();

    return newComments;
  }

  @override
  Future<List<Comment>> fetchNextPage(
      {@required DateTime startAfter, int limit = 20}) async {
    assert(startAfter != null);

    var newDocumentList = await _firestore
        .collection("comments")
        .orderBy("timestamp", descending: true)
        .startAfter([startAfter])
        .limit(limit)
        .getDocuments();

    var newComments = newDocumentList.documents
        .map(
          (v) => Comment.fromMap(
            v.data..addAll({'id': v.documentID}),
          ),
        )
        .toList();

    return newComments;
  }
}
