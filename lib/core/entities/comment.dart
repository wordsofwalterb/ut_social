import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Comment extends Equatable {
  final String authorId;
  final String postId;
  final String commentId;
  final String body;
  final int likeCount;
  final String authorName;
  final String authorAvatar;
  final DateTime timestamp;
  final String imageUrl;

  const Comment({
    @required this.authorId,
    @required this.postId,
    @required this.commentId,
    @required this.body,
    @required this.likeCount,
    @required this.authorName,
    @required this.authorAvatar,
    @required this.timestamp,
    this.imageUrl,
  })  : assert(authorId != null),
        assert(postId != null),
        assert(commentId != null),
        assert(body != null),
        assert(likeCount != null),
        assert(authorName != null),
        assert(timestamp != null);

  Comment copyWith({
    String authorId,
    String postId,
    String commentId,
    String body,
    int likeCount,
    String authorName,
    String authorAvatar,
    DateTime timestamp,
    String imageUrl,
  }) {
    return Comment(
      authorId: authorId ?? this.authorId,
      postId: postId ?? this.postId,
      commentId: commentId ?? this.commentId,
      body: body ?? this.body,
      likeCount: likeCount ?? this.likeCount,
      authorName: authorName ?? this.authorName,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      timestamp: timestamp ?? this.timestamp,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorId': authorId,
      'postId': postId,
      'commentId': commentId,
      'body': body,
      'likeCount': likeCount,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      authorId: map['authorId'] as String,
      postId: map['postId'] as String,
      commentId: map['commentId'] as String,
      body: map['body'] as String,
      likeCount: map['likeCount'] as int,
      authorName: map['authorName'] as String,
      authorAvatar: map['authorAvatar'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      authorId,
      postId,
      commentId,
      body,
      likeCount,
      authorName,
      authorAvatar,
      timestamp,
      imageUrl,
    ];
  }
}
