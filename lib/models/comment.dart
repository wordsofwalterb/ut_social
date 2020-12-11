import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    @required String id,
    @required String postId,
    @required String authorId,
    @required String authorName,
    @required String authorAvatar,
    @required DateTime timestamp,
    @required bool likedByUser,
    @Default(0) int likeCount,
    @Default([]) List<String> likedBy,
    @Default([]) List<String> unlikedBy,
    String imageUrl,
    String body,
    @Default(0) int reportCount,
    @Default([]) List<String> reportedBy,
    @Default(false) bool isBanned,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
