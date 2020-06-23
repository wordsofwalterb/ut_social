import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/comment.dart';
import 'package:ut_social/core/util/globals.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchNextPage(
      {@required DateTime startAfter, int limit, @required String postId});
  Future<List<Comment>> setupCommentsFor(String postId);
  Future<Comment> addComment(Map<String, dynamic> map);
  Future<void> unlikeComment(String commentId);
  Future<void> likeComment(String commentId);
  Future<void> deleteComment(String commentId);
}

class FirebaseCommentsRepository extends CommentRepository {
  final Firestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirebaseCommentsRepository({Firestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? Firestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<List<Comment>> setupCommentsFor(String postId) async {
    final newDocumentList = await _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .limit(20)
        .getDocuments();

    final currentUser = await _firebaseAuth.currentUser();
    final newComments = newDocumentList.documents
        .map((v) => Comment.fromMap(
              v.data
                ..addAll({
                  'id': v.documentID,
                  'isLikedByUser':
                      (v.data['likedBy'] as List).contains(currentUser.uid),
                }),
            ))
        .toList();

    return newComments;
  }

  @override
  Future<void> deleteComment(String commentId) async {
    assert(commentId != null);

    await Global.commentsRef.document(commentId).delete();
  }

  @override
  Future<List<Comment>> fetchNextPage(
      {@required DateTime startAfter,
      int limit = 20,
      @required String postId}) async {
    assert(startAfter != null);

    final newDocumentList = await _firestore
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('timestamp', descending: true)
        .startAfter([startAfter])
        .limit(limit)
        .getDocuments();
    final currentUser = await _firebaseAuth.currentUser();
    final newComments = newDocumentList.documents
        .map((v) => Comment.fromMap(
              v.data
                ..addAll({
                  'id': v.documentID,
                  'isLikedByUser':
                      (v.data['likedBy'] as List).contains(currentUser.uid)
                }),
            ))
        .toList();

    return newComments;
  }

  /// Creates new comment in Database and returns a new Comment Object
  /// based upon the passed map.
  ///
  /// PostId, AuthorId, and AuthorName must not be null
  @override
  Future<Comment> addComment(Map<String, dynamic> map) async {
    assert(map['postId'] != null);
    assert(map['authorId'] != null);
    assert(map['authorName'] != null);

    final DateTime timestamp = DateTime.now();

    final docRef = await Global.commentsRef.add({
      'postId': map['postId'],
      'body': map['body'],
      'authorId': map['authorId'],
      'authorName': map['authorName'],
      'authorAvatar': map['authorAvatar'],
      'likedBy': <String>[],
      'timestamp': timestamp,
      'likeCount': 0,
      'imageUrl': map['imageUrl'],
    });
    assert(docRef.documentID != null);

    return Comment(
        id: docRef.documentID,
        postId: map['postId'] as String,
        authorId: map['authorId'] as String,
        authorAvatar: map['authorAvatar'] as String,
        authorName: map['authorName'] as String,
        body: map['body'] as String,
        likedBy: const <String>[],
        isLikedByUser: false,
        timestamp: timestamp,
        likeCount: 0);
  }

  @override
  Future<void> unlikeComment(String commentId) async {
    final currentUser = await _firebaseAuth.currentUser();
    await Global.commentsRef.document(commentId).updateData({
      'likeCount': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([currentUser.uid])
    });
  }

  @override
  Future<void> likeComment(String commentId) async {
    final currentUser = await _firebaseAuth.currentUser();
    await Global.commentsRef.document(commentId).updateData({
      'likeCount': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([currentUser.uid])
    });
  }
}
