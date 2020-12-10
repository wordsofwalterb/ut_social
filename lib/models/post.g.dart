// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$_$_PostFromJson(Map<String, dynamic> json) {
  return _$_Post(
    id: json['id'] as String,
    authorId: json['authorId'] as String,
    authorName: json['authorName'] as String,
    postTime: json['postTime'] == null
        ? null
        : DateTime.parse(json['postTime'] as String),
    likedByUser: json['likedByUser'] as bool,
    imageUrl: json['imageUrl'] as String,
    unlikedBy:
        (json['unlikedBy'] as List)?.map((e) => e as String)?.toList() ?? [],
    avatarUrl: json['avatarUrl'] as String,
    likedBy: (json['likedBy'] as List)?.map((e) => e as String)?.toList() ?? [],
    body: json['body'] as String,
    commentCount: json['commentCount'] as int,
    likeCount: json['likeCount'] as int,
  );
}

Map<String, dynamic> _$_$_PostToJson(_$_Post instance) => <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'postTime': instance.postTime?.toIso8601String(),
      'likedByUser': instance.likedByUser,
      'imageUrl': instance.imageUrl,
      'unlikedBy': instance.unlikedBy,
      'avatarUrl': instance.avatarUrl,
      'likedBy': instance.likedBy,
      'body': instance.body,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
    };
