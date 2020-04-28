import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:ut_social/core/entities/student.dart';

import 'identity.dart';

@immutable
abstract class MessageSnippet extends Equatable implements Identity {
  const MessageSnippet();
}

class Message extends MessageSnippet {
  @override
  final String id;
  final StudentChatSnippet author;
  final String body;
  final bool isLikedByUser;
  final int likeCount;
  final DateTime timestamp;
  final String imageUrl;

  const Message({
    @required this.id,
    this.author,
    this.body,
    this.isLikedByUser,
    this.likeCount,
    this.timestamp,
    this.imageUrl,
  }) : assert(id != null);

  Message copyWith({
    String id,
    StudentChatSnippet author,
    String body,
    bool isLikedByUser,
    int likeCount,
    DateTime timestamp,
    String imageUrl,
  }) {
    return Message(
      id: id ?? this.id,
      author: author ?? this.author,
      body: body ?? this.body,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
      likeCount: likeCount ?? this.likeCount,
      timestamp: timestamp ?? this.timestamp,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author?.toMap(),
      'body': body,
      'isLikedByUser': isLikedByUser,
      'likeCount': likeCount,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      id: map['id'] as String ?? '',
      author: StudentChatSnippet.fromMap(map['author'] as Map<String, dynamic>),
      body: map['body'] as String ?? '',
      isLikedByUser: map['isLikedByUser'] as bool ?? false,
      likeCount: map['likeCount'] as int ?? 0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
      imageUrl: map['imageUrl'] as String ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [
      id,
      author,
      body,
      isLikedByUser,
      likeCount,
      timestamp,
      imageUrl,
    ];
  }

  @override
  bool get stringify => true;
}
