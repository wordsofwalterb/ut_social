import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:ut_social/core/entities/student.dart';

import 'identity.dart';
import 'message.dart';

@immutable
abstract class ChatSnippet extends Equatable implements Identity {
  @override
  String get id;
  String get name;

  const ChatSnippet();
}

class ChatOverviewSnippet extends ChatSnippet {
  final MessageSnippet lastMessage;
  @override
  final String id;
  @override
  final String name;
  final bool hasUnread;
  final int numberUnread;

  const ChatOverviewSnippet({
    this.lastMessage,
    this.id,
    this.name,
    this.hasUnread,
    this.numberUnread,
  });

  ChatOverviewSnippet copyWith({
    MessageSnippet lastMessage,
    String id,
    String name,
    bool hasUnread,
    int numberUnread,
  }) {
    return ChatOverviewSnippet(
      lastMessage: lastMessage ?? this.lastMessage,
      id: id ?? this.id,
      name: name ?? this.name,
      hasUnread: hasUnread ?? this.hasUnread,
      numberUnread: numberUnread ?? this.numberUnread,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //  'lastMessage': lastMessage?.toMap(),
      'id': id,
      'name': name,
      'hasUnread': hasUnread,
      'numberUnread': numberUnread,
    };
  }

  factory ChatOverviewSnippet.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChatOverviewSnippet(
      // lastMessage: MessageSnippet.fromMap(map['lastMessage']),
      id: map['id'].toString(),
      name: map['name'].toString(),
      hasUnread: map['hasUnread'] as bool ?? false,
      numberUnread: map['numberUnread'] as int ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatOverviewSnippet.fromJson(String source) =>
      ChatOverviewSnippet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [
      lastMessage,
      id,
      name,
      hasUnread,
      numberUnread,
    ];
  }

  @override
  bool get stringify => true;
}

class Chat extends ChatSnippet implements Identity {
  @override
  final String id;
  @override
  final String name;
  final List<StudentChatSnippet> members;
  final List<Message> messages;

  const Chat({
    this.id,
    this.name,
    this.members,
    this.messages,
  });

  Chat copyWith({
    String id,
    String name,
    List<StudentChatSnippet> members,
    List<Message> messages,
  }) {
    return Chat(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'members': members?.map((x) => x?.toMap())?.toList(),
      'messages': messages?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Chat(
      id: map['id'].toString(),
      name: map['name'].toString(),
      members: List<StudentChatSnippet>.from(
          (map['members'] as List<Map<String, dynamic>>)
              ?.map((Map<String, dynamic> x) => StudentChatSnippet.fromMap(x))
              ?.toList()),
      messages: List<Message>.from(
          (map['messages'] as List<Map<String, dynamic>>)
              ?.map((Map<String, dynamic> x) => Message.fromMap(x))
              ?.toList()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, members, messages];
}
