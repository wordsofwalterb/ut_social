import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String authorId;
  final String postId;
  final String id;
  final String body;
  final int likeCount;
  final String authorName;
  final String authorAvatar;
  final DateTime timestamp;
  final String imageUrl;
  final bool isLikedByUser;
  final List<String> likedBy;
  final List<String> unlikedBy;

  const Comment(
      {this.authorId,
      this.postId,
      this.id,
      this.body,
      this.likeCount,
      this.authorName,
      this.authorAvatar,
      this.isLikedByUser,
      this.unlikedBy,
      this.timestamp,
      this.imageUrl,
      this.likedBy});

  Comment copyWith({
    String authorId,
    String postId,
    String id,
    String body,
    int likeCount,
    String authorName,
    String authorAvatar,
    DateTime timestamp,
    String imageUrl,
    bool isLikedByUser,
    List<String> unlikedBy,
    List<String> likedBy,
  }) {
    return Comment(
        authorId: authorId ?? this.authorId,
        postId: postId ?? this.postId,
        isLikedByUser: isLikedByUser ?? this.isLikedByUser,
        id: id ?? this.id,
        body: body ?? this.body,
        likeCount: likeCount ?? this.likeCount,
        authorName: authorName ?? this.authorName,
        authorAvatar: authorAvatar ?? this.authorAvatar,
        timestamp: timestamp ?? this.timestamp,
        imageUrl: imageUrl ?? this.imageUrl,
        unlikedBy: unlikedBy ?? this.unlikedBy,
        likedBy: likedBy ?? this.likedBy);
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'postId': postId,
      'id': id,
      'body': body,
      'likeCount': likeCount,
      'authorName': authorName,
      'isLikedByUser': isLikedByUser,
      'authorAvatar': authorAvatar,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
      'unlikedBy': unlikedBy,
      'likedBy': likedBy,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      authorId: map['authorId'] as String,
      postId: map['postId'] as String,
      id: map['id'] as String,
      body: map['body'] as String,
      likeCount: map['likeCount'] as int,
      isLikedByUser: map['isLikedByUser'] as bool,
      authorName: map['authorName'] as String,
      authorAvatar: map['authorAvatar'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      imageUrl: map['imageUrl'] as String,
      unlikedBy: List<String>.from((map['unlikedBy'] as List) ?? []),
      likedBy: List<String>.from(map['likedBy'] as List),
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
      id,
      body,
      likeCount,
      authorName,
      authorAvatar,
      unlikedBy,
      timestamp,
      imageUrl,
    ];
  }
}
