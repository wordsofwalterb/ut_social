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

  Comment({
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
    return {
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

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      authorId: map['authorId'],
      postId: map['postId'],
      commentId: map['commentId'],
      body: map['body'],
      likeCount: map['likeCount'],
      authorName: map['authorName'],
      authorAvatar: map['authorAvatar'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static Comment fromJson(String source) => fromMap(json.decode(source));

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
