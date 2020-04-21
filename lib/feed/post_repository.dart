import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> fetchNextPage({dynamic startAt, int limit});
  Future<List<Post>> fetchAllPosts();
}

class FirebasePostRepository extends PostRepository {
  final Firestore _firestore;

  FirebasePostRepository({Firestore firestore})
      : _firestore = firestore ?? Firestore.instance;

  @override
  Future<List<Post>> fetchAllPosts() async {
    var newDocumentList = await _firestore
        .collection("posts")
        .orderBy("postTime", descending: true)
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
      {@required dynamic startAt, int limit = 20}) async {
    assert(startAt != null);
    assert(startAt.runtimeType == DocumentSnapshot);

    var newDocumentList = await _firestore
        .collection("posts")
        .orderBy("postTime", descending: true)
        .startAfterDocument(startAt)
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
}
