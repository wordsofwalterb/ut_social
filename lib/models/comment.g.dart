// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$_$_CommentFromJson(Map<String, dynamic> json) {
  return _$_Comment(
    id: json['id'] as String,
    postId: json['postId'] as String,
    authorId: json['authorId'] as String,
    authorName: json['authorName'] as String,
    authorAvatar: json['authorAvatar'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    likedByUser: json['likedByUser'] as bool,
    likeCount: json['likeCount'] as int ?? 0,
    likedBy: (json['likedBy'] as List)?.map((e) => e as String)?.toList() ?? [],
    unlikedBy:
        (json['unlikedBy'] as List)?.map((e) => e as String)?.toList() ?? [],
    imageUrl: json['imageUrl'] as String,
    body: json['body'] as String,
    reportCount: json['reportCount'] as int ?? 0,
    reportedBy:
        (json['reportedBy'] as List)?.map((e) => e as String)?.toList() ?? [],
    isBanned: json['isBanned'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorAvatar': instance.authorAvatar,
      'timestamp': instance.timestamp?.toIso8601String(),
      'likedByUser': instance.likedByUser,
      'likeCount': instance.likeCount,
      'likedBy': instance.likedBy,
      'unlikedBy': instance.unlikedBy,
      'imageUrl': instance.imageUrl,
      'body': instance.body,
      'reportCount': instance.reportCount,
      'reportedBy': instance.reportedBy,
      'isBanned': instance.isBanned,
    };
