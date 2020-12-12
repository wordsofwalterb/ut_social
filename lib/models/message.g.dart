// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextMessage _$_$TextMessageFromJson(Map<String, dynamic> json) {
  return _$TextMessage(
    body: json['body'] as String,
    id: json['id'] as String,
    channelId: json['channelId'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    reportCount: json['reportCount'] as int,
    author: json['author'] as Map<String, dynamic>,
    replies: (json['replies'] as List)?.map((e) => e as String)?.toList(),
    reactions: (json['reactions'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$_$TextMessageToJson(_$TextMessage instance) =>
    <String, dynamic>{
      'body': instance.body,
      'id': instance.id,
      'channelId': instance.channelId,
      'timestamp': instance.timestamp?.toIso8601String(),
      'reportCount': instance.reportCount,
      'author': instance.author,
      'replies': instance.replies,
      'reactions': instance.reactions,
    };

_$ImageMessage _$_$ImageMessageFromJson(Map<String, dynamic> json) {
  return _$ImageMessage(
    imageUrls: (json['imageUrls'] as List)?.map((e) => e as String)?.toList(),
    id: json['id'] as String,
    channelId: json['channelId'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    reportCount: json['reportCount'] as int,
    author: json['author'] as Map<String, dynamic>,
    replies: (json['replies'] as List)?.map((e) => e as String)?.toList(),
    reactions: (json['reactions'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
  );
}

Map<String, dynamic> _$_$ImageMessageToJson(_$ImageMessage instance) =>
    <String, dynamic>{
      'imageUrls': instance.imageUrls,
      'id': instance.id,
      'channelId': instance.channelId,
      'timestamp': instance.timestamp?.toIso8601String(),
      'reportCount': instance.reportCount,
      'author': instance.author,
      'replies': instance.replies,
      'reactions': instance.reactions,
    };
