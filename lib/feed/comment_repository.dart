import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/comment.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/globals.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchNextPage({DateTime startAfter, int limit});
  Future<List<Comment>> setupFeed(String postId);
  Future<Comment> addComment(String commentId, Student author, String body);
}

class FirebaseCommentRepository extends CommentRepository {
  final Firestore _firestore;

  FirebaseCommentRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Future<List<Comment>> setupFeed(String postId) async {
    var newDocumentList = await _firestore
        .collection("comments")
        .where('postId', isEqualTo: postId)
        .orderBy("timestamp", descending: true)
        .limit(20)
        .getDocuments();

    var newComments = newDocumentList.documents
        .map(
          (v) => Comment.fromMap(
            v.data..addAll({'commentId': v.documentID}),
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
        .where('timestamp', isLessThan: startAfter)
        .startAfter([startAfter])
        .limit(limit)
        .getDocuments();

    var newComments = newDocumentList.documents
        .map(
          (v) => Comment.fromMap(
            v.data..addAll({'commentId': v.documentID}),
          ),
        )
        .toList();

    return newComments;
  }

  Future<void> unlikeComment(String commentId) async {
    await Global.commentsRef.document(commentId).updateData({
      'likeCount': FieldValue.increment(-1),
    });
  }

  /// Creates new comment in Database and returns a new Comment Object
  Future<Comment> addComment(String postId, Student author, String body) async {
    assert(postId != null);
    assert(author != null);
    assert(body != null);

    final timestamp = DateTime.now();

    var docRef = await Global.commentsRef.add({
      'postId': postId,
      'body': body,
      'authorId': author.id,
      'authorName': author.fullName,
      'authorAvatar': author.avatarUrl,
      'timestamp': timestamp,
      'likeCount': 0,
      'imageUrl': '',
    });
    assert(docRef.documentID != null);

    return Comment(
        commentId: docRef.documentID,
        postId: postId,
        authorId: author.id,
        authorAvatar: author.avatarUrl,
        authorName: author.fullName,
        body: body,
        timestamp: timestamp,
        likeCount: 0);
  }

  Future<void> likeComment(String commentId) async {
    await Global.commentsRef.document(commentId).updateData({
      'likeCount': FieldValue.increment(1),
    });
  }
}
