import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class Message with _$Message {
  // const factory Message._();

  const factory Message.textMessage({
    @required String body,
    @required String id,
    @required String channelId,
    @required DateTime timestamp,
    @required int reportCount,
    @required Map<String, dynamic> author,
    List<String> replies,
    List<Map<String, dynamic>> reactions,
  }) = TextMessage;

  const factory Message.imageMessage({
    @required List<String> imageUrls,
    @required String id,
    @required String channelId,
    @required DateTime timestamp,
    @required int reportCount,
    @required Map<String, dynamic> author,
    List<String> replies,
    List<Map<String, dynamic>> reactions,
  }) = ImageMessage;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

// abstract class Message extends Equatable {
//   final String id;
//   final String channelId;
//   final DateTime timestamp;
//   final int reportCount;
//   final Map<String, dynamic> author;
//   final List<String> replies;
//   final List<Map<String, dynamic>> reactions;

//   const Message({
//     @required this.id,
//     @required this.channelId,
//     @required this.timestamp,
//     @required this.reportCount,
//     @required this.author,
//     this.replies,
//     this.reactions,
//   })  : assert(id != null),
//         assert(channelId != null),
//         assert(timestamp != null),
//         assert(reportCount != null),
//         assert(author != null);

//   Message copyWith({
//     String id,
//     String channelId,
//     DateTime timestamp,
//     int reportCount,
//     Map<String, dynamic> author,
//     List<String> replies,
//     List<Map<String, dynamic>> reactions,
//   });

//   Map<String, dynamic> toMap();
// }

// class TextMessage extends Message {
//   final String body;

//   const TextMessage({
//     @required this.body,
//     @required String id,
//     @required String channelId,
//     @required DateTime timestamp,
//     @required int reportCount,
//     @required Map<String, dynamic> author,
//     List<String> replies,
//     List<Map<String, dynamic>> reactions,
//   })  : assert(body != null),
//         assert(id != null),
//         assert(channelId != null),
//         assert(timestamp != null),
//         assert(reportCount != null),
//         assert(author != null),
//         super(
//           id: id,
//           channelId: channelId,
//           timestamp: timestamp,
//           reportCount: reportCount,
//           author: author,
//           replies: replies,
//           reactions: reactions,
//         );

//   @override
//   TextMessage copyWith({
//     String body,
//     String id,
//     String channelId,
//     DateTime timestamp,
//     int reportCount,
//     Map<String, dynamic> author,
//     List<String> replies,
//     List<Map<String, dynamic>> reactions,
//   }) {
//     return TextMessage(
//       body: body ?? this.body,
//       id: id ?? this.id,
//       channelId: channelId ?? this.channelId,
//       timestamp: timestamp ?? this.timestamp,
//       reportCount: reportCount ?? this.reportCount,
//       author: author ?? this.author,
//       replies: replies ?? this.replies,
//       reactions: reactions ?? this.reactions,
//     );
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     return {
//       'body': body,
//       'id': id,
//       'channelId': channelId,
//       'replies': replies,
//       'timestamp': timestamp,
//       'reportCount': reportCount,
//       'author': author,
//       'reactions': reactions,
//     };
//   }

//   factory TextMessage.fromMap(Map<String, dynamic> map) {
//     assert(map != null);
//     if (map == null) return null;

//     return TextMessage(
//       body: map['body'] as String,
//       id: map['id'] as String,
//       channelId: map['channelId'] as String,
//       replies: List<String>.from(map['replies'] as List),
//       timestamp: (map['postTime'] as Timestamp).toDate(),
//       reportCount: map['reportCount'] as int,
//       author: Map<String, dynamic>.from(map['author'] as Map),
//       reactions: List<Map<String, dynamic>>.from(
//           (map['reactions'] as List)?.map((x) => x as Map)),
//     );
//   }

//   @override
//   List<Object> get props {
//     return [
//       body,
//       id,
//       channelId,
//       replies,
//       timestamp,
//       reportCount,
//       author,
//       reactions,
//     ];
//   }
// }

// class ImageMessage extends Message {
//   final List<String> imageUrls;

//   const ImageMessage({
//     @required this.imageUrls,
//     @required String id,
//     @required String channelId,
//     @required DateTime timestamp,
//     @required int reportCount,
//     @required Map<String, dynamic> author,
//     List<String> replies,
//     List<Map<String, dynamic>> reactions,
//   })  : assert(imageUrls != null),
//         assert(id != null),
//         assert(channelId != null),
//         assert(timestamp != null),
//         assert(reportCount != null),
//         assert(author != null),
//         super(
//           id: id,
//           channelId: channelId,
//           timestamp: timestamp,
//           reportCount: reportCount,
//           author: author,
//           replies: replies,
//           reactions: reactions,
//         );

//   @override
//   ImageMessage copyWith({
//     List<String> imageUrls,
//     String id,
//     String channelId,
//     DateTime timestamp,
//     int reportCount,
//     Map<String, dynamic> author,
//     List<String> replies,
//     List<Map<String, dynamic>> reactions,
//   }) {
//     return ImageMessage(
//       imageUrls: imageUrls ?? this.imageUrls,
//       id: id ?? this.id,
//       channelId: channelId ?? this.channelId,
//       timestamp: timestamp ?? this.timestamp,
//       reportCount: reportCount ?? this.reportCount,
//       author: author ?? this.author,
//       replies: replies ?? this.replies,
//       reactions: reactions ?? this.reactions,
//     );
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     return {
//       'imageUrls': imageUrls,
//       'id': id,
//       'channelId': channelId,
//       'replies': replies,
//       'timestamp': timestamp,
//       'reportCount': reportCount,
//       'author': author,
//       'reactions': reactions,
//     };
//   }

//   factory ImageMessage.fromMap(Map<String, dynamic> map) {
//     assert(map != null);
//     if (map == null) return null;

//     return ImageMessage(
//       imageUrls: List<String>.from(map['imageUrls'] as List),
//       id: map['id'] as String,
//       channelId: map['channelId'] as String,
//       replies: List<String>.from(map['replies'] as List),
//       timestamp: (map['postTime'] as Timestamp).toDate(),
//       reportCount: map['reportCount'] as int,
//       author: Map<String, dynamic>.from(map['author'] as Map),
//       reactions: (map['reactions'] as List)
//           ?.map((x) => Map<String, dynamic>.from(x as Map))
//           ?.toList(),
//     );
//   }

//   @override
//   List<Object> get props {
//     return [
//       imageUrls,
//       id,
//       channelId,
//       replies,
//       timestamp,
//       reportCount,
//       author,
//       reactions,
//     ];
//   }
// }
