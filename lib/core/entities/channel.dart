import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Represents both groups chats and direct conversations between two students.
class Channel extends Equatable {
  final String id;

  /// Only used in direct messages, in which case it is a map of two participants.
  /// Attributes:
  ///   id: String + Required
  ///   name: String + Required
  ///   avatarUrl: String + Nullable
  final Map<String, Map<String, dynamic>> participants;

  /// In the case that channelProperties indicates this is a direct message channel,
  /// channel name should be set to name of the other Student in the conversation.
  /// This information is would be available in participants.
  final String channelName;

  /// The url to the image representing a group channel
  ///
  /// In the case that channelProperties indicates this is a direct message channel,
  /// channel name should be set to avatarUrl of the other Student in the conversation
  /// This information is would be available in participants.
  final String channelImageUrl;

  /// The various properties related to configuration of the channel.
  ///
  /// In particular importance are the required attributes:
  /// Attributes:
  ///   isPrivate: bool + Required
  ///   isDM : bool + Required // This indicates a conversation between only two users
  final Map<String, dynamic> channelProperties;

  /// The privileged users and their related attributes.
  ///
  /// The key for each student is the FK for the student represented.
  /// Attributes:
  ///   name: String + Required
  ///   permissions: Map + Required
  ///   avatarUrl: String + Nullable
  final Map<String, Map<String, dynamic>> privilegedUsers;

  /// The last message sent within the channel.
  ///
  /// In the case the last message was not a text message, body should written manually.
  /// Attributes:
  ///   authorName : String + Required
  ///   timestamp : DateTime + Required
  ///   body: String + Required
  final Map<String, dynamic> lastMessage;

  /// Represents either a group chat or a direct conversation between two students.
  ///
  /// The type of channel is determined by the isDM property within [channelProperties].
  /// [participants] is only used in the case of a direct conversation.
  /// [id] and [channelProperties] are both required.
  const Channel({
    @required this.id,
    @required this.channelProperties,
    this.participants,
    this.channelName,
    this.channelImageUrl,
    this.privilegedUsers,
    this.lastMessage,
  })  : assert(id != null),
        assert(channelProperties != null);

  Channel copyWith({
    String id,
    Map<String, Map<String, dynamic>> participants,
    String channelName,
    String channelImageUrl,
    Map<String, dynamic> channelProperties,
    Map<String, Map<String, dynamic>> privilegedUsers,
    Map<String, dynamic> lastMessage,
  }) {
    return Channel(
      id: id ?? this.id,
      participants: participants ?? this.participants,
      channelName: channelName ?? this.channelName,
      channelImageUrl: channelImageUrl ?? this.channelImageUrl,
      channelProperties: channelProperties ?? this.channelProperties,
      privilegedUsers: privilegedUsers ?? this.privilegedUsers,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participants': participants,
      'channelName': channelName,
      'channelImageUrl': channelImageUrl,
      'channelProperties': channelProperties,
      'privilegedUsers': privilegedUsers,
      'lastMessage': lastMessage,
    };
  }

  /// Creates a new channel from a map and the currentUserId
  ///
  /// [id], [channelProperties], and [currentUserId] must not be null.
  /// Returns null if map == null, map['channelProperties']['isDm'] == null
  factory Channel.fromMap(Map<String, dynamic> map, String currentUserId) {
    assert(currentUserId != null);
    assert(map != null);
    if (map == null ||
        map['channelProperties'] == null ||
        map['channelProperties']['isDM'] == null) {
      return null;
    }

    String newName;
    String newImageUrl;
    Map<String, Map<String, dynamic>> participants;

    // If channel type is DM set name and image equal to the other student
    if (map['channelProperties']['isDM'] as bool &&
        map['participants'] != null) {
      participants =
          Map<String, Map<String, dynamic>>.from(map['participants'] as Map);
      participants.forEach((key, value) {
        if (key != currentUserId) {
          newName = value['name'] as String;
          newImageUrl = value['avatarUrl'] as String;
        }
      });
    }

    return Channel(
      id: map['id'] as String,
      participants: participants,
      channelName: newName ?? map['channelName'] as String,
      channelImageUrl: newImageUrl ?? map['channelImageUrl'] as String,
      channelProperties:
          Map<String, dynamic>.from(map['channelProperties'] as Map),
      privilegedUsers:
          Map<String, Map<String, dynamic>>.from(map['privilegedUsers'] as Map),
      lastMessage: Map<String, dynamic>.from(map['lastMessage'] as Map),
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      participants,
      channelName,
      channelImageUrl,
      channelProperties,
      privilegedUsers,
      lastMessage,
    ];
  }

  @override
  bool get stringify => true;
}
