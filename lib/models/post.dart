import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/foundation.dart';

class Post extends Equatable {
  final String id;
  final String authorId, authorName, body, avatarUrl, imageUrl;
  final DateTime postTime;
  final int commentCount, likeCount;
  final bool likedByUser;
  final List<String> unlikedBy;
  // List of student ids that liked this post
  final List<String> likedBy;

  const Post(
      {@required this.id,
      @required this.authorId,
      @required this.authorName,
      @required this.postTime,
      this.likedByUser,
      this.imageUrl,
      this.unlikedBy,
      this.avatarUrl,
      this.likedBy,
      this.body,
      this.commentCount,
      this.likeCount})
      : assert(id != null),
        assert(authorId != null),
        assert(authorName != null),
        assert(postTime != null);

  Post copyWith(
      {String id,
      String authorId,
      String authorName,
      String imageUrl,
      DateTime postTime,
      String body,
      List<String> unlikedBy,
      List<String> likedBy,
      String avatarUrl,
      bool likedByUser,
      int commentCount,
      int likeCount}) {
    return Post(
      id: id ?? this.id,
      likedBy: likedBy ?? this.likedBy,
      imageUrl: imageUrl ?? this.imageUrl,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      authorId: authorId ?? this.authorId,
      unlikedBy: unlikedBy ?? this.unlikedBy,
      authorName: authorName ?? this.authorName,
      postTime: postTime ?? this.postTime,
      body: body ?? this.body,
      commentCount: commentCount ?? this.commentCount,
      likedByUser: likedByUser ?? this.likedByUser,
      likeCount: likeCount ?? this.likeCount,
    );
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        imageUrl: map['imageUrl'] as String,
        id: map['id'] as String,
        likedBy: List<String>.from(map['likedBy'] as List),
        avatarUrl: map['avatarUrl'] as String,
        authorId: map['authorId'] as String,
        authorName: map['authorName'] as String,
        postTime: (map['postTime'] as Timestamp).toDate(),
        body: map['body'] as String,
        unlikedBy: List<String>.from((map['unlikedBy'] as List) ?? []),
        likedByUser: map['isLikedByUser'] as bool,
        commentCount: map['commentCount'] as int,
        likeCount: map['likeCount'] as int);
  }

  @override
  List<Object> get props => <Object>[
        imageUrl,
        id,
        likedBy,
        avatarUrl,
        authorId,
        authorName,
        postTime,
        unlikedBy,
        body,
        commentCount,
        likeCount,
        likedByUser,
      ];
}
