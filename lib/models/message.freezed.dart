// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Message _$MessageFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'textMessage':
      return TextMessage.fromJson(json);
    case 'imageMessage':
      return ImageMessage.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$MessageTearOff {
  const _$MessageTearOff();

// ignore: unused_element
  TextMessage textMessage(
      {@required String body,
      @required String id,
      @required String channelId,
      @required DateTime timestamp,
      @required int reportCount,
      @required Map<String, dynamic> author,
      List<String> replies,
      List<Map<String, dynamic>> reactions}) {
    return TextMessage(
      body: body,
      id: id,
      channelId: channelId,
      timestamp: timestamp,
      reportCount: reportCount,
      author: author,
      replies: replies,
      reactions: reactions,
    );
  }

// ignore: unused_element
  ImageMessage imageMessage(
      {@required List<String> imageUrls,
      @required String id,
      @required String channelId,
      @required DateTime timestamp,
      @required int reportCount,
      @required Map<String, dynamic> author,
      List<String> replies,
      List<Map<String, dynamic>> reactions}) {
    return ImageMessage(
      imageUrls: imageUrls,
      id: id,
      channelId: channelId,
      timestamp: timestamp,
      reportCount: reportCount,
      author: author,
      replies: replies,
      reactions: reactions,
    );
  }

// ignore: unused_element
  Message fromJson(Map<String, Object> json) {
    return Message.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Message = _$MessageTearOff();

/// @nodoc
mixin _$Message {
  String get id;
  String get channelId;
  DateTime get timestamp;
  int get reportCount;
  Map<String, dynamic> get author;
  List<String> get replies;
  List<Map<String, dynamic>> get reactions;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult textMessage(
            String body,
            String id,
            String channelId,
            DateTime timestamp,
            int reportCount,
            Map<String, dynamic> author,
            List<String> replies,
            List<Map<String, dynamic>> reactions),
    @required
        TResult imageMessage(
            List<String> imageUrls,
            String id,
            String channelId,
            DateTime timestamp,
            int reportCount,
            Map<String, dynamic> author,
            List<String> replies,
            List<Map<String, dynamic>> reactions),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult textMessage(
        String body,
        String id,
        String channelId,
        DateTime timestamp,
        int reportCount,
        Map<String, dynamic> author,
        List<String> replies,
        List<Map<String, dynamic>> reactions),
    TResult imageMessage(
        List<String> imageUrls,
        String id,
        String channelId,
        DateTime timestamp,
        int reportCount,
        Map<String, dynamic> author,
        List<String> replies,
        List<Map<String, dynamic>> reactions),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult textMessage(TextMessage value),
    @required TResult imageMessage(ImageMessage value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult textMessage(TextMessage value),
    TResult imageMessage(ImageMessage value),
    @required TResult orElse(),
  });
  Map<String, dynamic> toJson();
  $MessageCopyWith<Message> get copyWith;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String channelId,
      DateTime timestamp,
      int reportCount,
      Map<String, dynamic> author,
      List<String> replies,
      List<Map<String, dynamic>> reactions});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object id = freezed,
    Object channelId = freezed,
    Object timestamp = freezed,
    Object reportCount = freezed,
    Object author = freezed,
    Object replies = freezed,
    Object reactions = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      channelId: channelId == freezed ? _value.channelId : channelId as String,
      timestamp:
          timestamp == freezed ? _value.timestamp : timestamp as DateTime,
      reportCount:
          reportCount == freezed ? _value.reportCount : reportCount as int,
      author:
          author == freezed ? _value.author : author as Map<String, dynamic>,
      replies: replies == freezed ? _value.replies : replies as List<String>,
      reactions: reactions == freezed
          ? _value.reactions
          : reactions as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
abstract class $TextMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $TextMessageCopyWith(
          TextMessage value, $Res Function(TextMessage) then) =
      _$TextMessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String body,
      String id,
      String channelId,
      DateTime timestamp,
      int reportCount,
      Map<String, dynamic> author,
      List<String> replies,
      List<Map<String, dynamic>> reactions});
}

/// @nodoc
class _$TextMessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements $TextMessageCopyWith<$Res> {
  _$TextMessageCopyWithImpl(
      TextMessage _value, $Res Function(TextMessage) _then)
      : super(_value, (v) => _then(v as TextMessage));

  @override
  TextMessage get _value => super._value as TextMessage;

  @override
  $Res call({
    Object body = freezed,
    Object id = freezed,
    Object channelId = freezed,
    Object timestamp = freezed,
    Object reportCount = freezed,
    Object author = freezed,
    Object replies = freezed,
    Object reactions = freezed,
  }) {
    return _then(TextMessage(
      body: body == freezed ? _value.body : body as String,
      id: id == freezed ? _value.id : id as String,
      channelId: channelId == freezed ? _value.channelId : channelId as String,
      timestamp:
          timestamp == freezed ? _value.timestamp : timestamp as DateTime,
      reportCount:
          reportCount == freezed ? _value.reportCount : reportCount as int,
      author:
          author == freezed ? _value.author : author as Map<String, dynamic>,
      replies: replies == freezed ? _value.replies : replies as List<String>,
      reactions: reactions == freezed
          ? _value.reactions
          : reactions as List<Map<String, dynamic>>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$TextMessage with DiagnosticableTreeMixin implements TextMessage {
  const _$TextMessage(
      {@required this.body,
      @required this.id,
      @required this.channelId,
      @required this.timestamp,
      @required this.reportCount,
      @required this.author,
      this.replies,
      this.reactions})
      : assert(body != null),
        assert(id != null),
        assert(channelId != null),
        assert(timestamp != null),
        assert(reportCount != null),
        assert(author != null);

  factory _$TextMessage.fromJson(Map<String, dynamic> json) =>
      _$_$TextMessageFromJson(json);

  @override
  final String body;
  @override
  final String id;
  @override
  final String channelId;
  @override
  final DateTime timestamp;
  @override
  final int reportCount;
  @override
  final Map<String, dynamic> author;
  @override
  final List<String> replies;
  @override
  final List<Map<String, dynamic>> reactions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message.textMessage(body: $body, id: $id, channelId: $channelId, timestamp: $timestamp, reportCount: $reportCount, author: $author, replies: $replies, reactions: $reactions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message.textMessage'))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('channelId', channelId))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('reportCount', reportCount))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('replies', replies))
      ..add(DiagnosticsProperty('reactions', reactions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TextMessage &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.channelId, channelId) ||
                const DeepCollectionEquality()
                    .equals(other.channelId, channelId)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.reportCount, reportCount) ||
                const DeepCollectionEquality()
                    .equals(other.reportCount, reportCount)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.replies, replies) ||
                const DeepCollectionEquality()
                    .equals(other.replies, replies)) &&
            (identical(other.reactions, reactions) ||
                const DeepCollectionEquality()
                    .equals(other.reactions, reactions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(channelId) ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(reportCount) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(replies) ^
      const DeepCollectionEquality().hash(reactions);

  @override
  $TextMessageCopyWith<TextMessage> get copyWith =>
      _$TextMessageCopyWithImpl<TextMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult textMessage(
            String body,
            String id,
            String channelId,
            DateTime timestamp,
            int reportCount,
            Map<String, dynamic> author,
            List<String> replies,
            List<Map<String, dynamic>> reactions),
    @required
        TResult imageMessage(
            List<String> imageUrls,
            String id,
            String channelId,
            DateTime timestamp,
            int reportCount,
            Map<String, dynamic> author,
            List<String> replies,
            List<Map<String, dynamic>> reactions),
  }) {
    assert(textMessage != null);
    assert(imageMessage != null);
    return textMessage(body, id, channelId, timestamp, reportCount, author,
        replies, reactions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult textMessage(
        String body,
        String id,
        String channelId,
        DateTime timestamp,
        int reportCount,
        Map<String, dynamic> author,
        List<String> replies,
        List<Map<String, dynamic>> reactions),
    TResult imageMessage(
        List<String> imageUrls,
        String id,
        String channelId,
        DateTime timestamp,
        int reportCount,
        Map<String, dynamic> author,
        List<String> replies,
        List<Map<String, dynamic>> reactions),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (textMessage != null) {
      return textMessage(body, id, channelId, timestamp, reportCount, author,
          replies, reactions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult textMessage(TextMessage value),
    @required TResult imageMessage(ImageMessage value),
  }) {
    assert(textMessage != null);
    assert(imageMessage != null);
    return textMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult textMessage(TextMessage value),
    TResult imageMessage(ImageMessage value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (textMessage != null) {
      return textMessage(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$TextMessageToJson(this)..['runtimeType'] = 'textMessage';
  }
}

abstract class TextMessage implements Message {
  const factory TextMessage(
      {@required String body,
      @required String id,
      @required String channelId,
      @required DateTime timestamp,
      @required int reportCount,
      @required Map<String, dynamic> author,
      List<String> replies,
      List<Map<String, dynamic>> reactions}) = _$TextMessage;

  factory TextMessage.fromJson(Map<String, dynamic> json) =
      _$TextMessage.fromJson;

  String get body;
  @override
  String get id;
  @override
  String get channelId;
  @override
  DateTime get timestamp;
  @override
  int get reportCount;
  @override
  Map<String, dynamic> get author;
  @override
  List<String> get replies;
  @override
  List<Map<String, dynamic>> get reactions;
  @override
  $TextMessageCopyWith<TextMessage> get copyWith;
}

/// @nodoc
abstract class $ImageMessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory $ImageMessageCopyWith(
          ImageMessage value, $Res Function(ImageMessage) then) =
      _$ImageMessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<String> imageUrls,
      String id,
      String channelId,
      DateTime timestamp,
      int reportCount,
      Map<String, dynamic> author,
      List<String> replies,
      List<Map<String, dynamic>> reactions});
}

/// @nodoc
class _$ImageMessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements $ImageMessageCopyWith<$Res> {
  _$ImageMessageCopyWithImpl(
      ImageMessage _value, $Res Function(ImageMessage) _then)
      : super(_value, (v) => _then(v as ImageMessage));

  @override
  ImageMessage get _value => super._value as ImageMessage;

  @override
  $Res call({
    Object imageUrls = freezed,
    Object id = freezed,
    Object channelId = freezed,
    Object timestamp = freezed,
    Object reportCount = freezed,
    Object author = freezed,
    Object replies = freezed,
    Object reactions = freezed,
  }) {
    return _then(ImageMessage(
      imageUrls:
          imageUrls == freezed ? _value.imageUrls : imageUrls as List<String>,
      id: id == freezed ? _value.id : id as String,
      channelId: channelId == freezed ? _value.channelId : channelId as String,
      timestamp:
          timestamp == freezed ? _value.timestamp : timestamp as DateTime,
      reportCount:
          reportCount == freezed ? _value.reportCount : reportCount as int,
      author:
          author == freezed ? _value.author : author as Map<String, dynamic>,
      replies: replies == freezed ? _value.replies : replies as List<String>,
      reactions: reactions == freezed
          ? _value.reactions
          : reactions as List<Map<String, dynamic>>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$ImageMessage with DiagnosticableTreeMixin implements ImageMessage {
  const _$ImageMessage(
      {@required this.imageUrls,
      @required this.id,
      @required this.channelId,
      @required this.timestamp,
      @required this.reportCount,
      @required this.author,
      this.replies,
      this.reactions})
      : assert(imageUrls != null),
        assert(id != null),
        assert(channelId != null),
        assert(timestamp != null),
        assert(reportCount != null),
        assert(author != null);

  factory _$ImageMessage.fromJson(Map<String, dynamic> json) =>
      _$_$ImageMessageFromJson(json);

  @override
  final List<String> imageUrls;
  @override
  final String id;
  @override
  final String channelId;
  @override
  final DateTime timestamp;
  @override
  final int reportCount;
  @override
  final Map<String, dynamic> author;
  @override
  final List<String> replies;
  @override
  final List<Map<String, dynamic>> reactions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Message.imageMessage(imageUrls: $imageUrls, id: $id, channelId: $channelId, timestamp: $timestamp, reportCount: $reportCount, author: $author, replies: $replies, reactions: $reactions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Message.imageMessage'))
      ..add(DiagnosticsProperty('imageUrls', imageUrls))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('channelId', channelId))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('reportCount', reportCount))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('replies', replies))
      ..add(DiagnosticsProperty('reactions', reactions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ImageMessage &&
            (identical(other.imageUrls, imageUrls) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrls, imageUrls)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.channelId, channelId) ||
                const DeepCollectionEquality()
                    .equals(other.channelId, channelId)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.reportCount, reportCount) ||
                const DeepCollectionEquality()
                    .equals(other.reportCount, reportCount)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.replies, replies) ||
                const DeepCollectionEquality()
                    .equals(other.replies, replies)) &&
            (identical(other.reactions, reactions) ||
                const DeepCollectionEquality()
                    .equals(other.reactions, reactions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(imageUrls) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(channelId) ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(reportCount) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(replies) ^
      const DeepCollectionEquality().hash(reactions);

  @override
  $ImageMessageCopyWith<ImageMessage> get copyWith =>
      _$ImageMessageCopyWithImpl<ImageMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult textMessage(
            String body,
            String id,
            String channelId,
            DateTime timestamp,
            int reportCount,
            Map<String, dynamic> author,
            List<String> replies,
            List<Map<String, dynamic>> reactions),
    @required
        TResult imageMessage(
            List<String> imageUrls,
            String id,
            String channelId,
            DateTime timestamp,
            int reportCount,
            Map<String, dynamic> author,
            List<String> replies,
            List<Map<String, dynamic>> reactions),
  }) {
    assert(textMessage != null);
    assert(imageMessage != null);
    return imageMessage(imageUrls, id, channelId, timestamp, reportCount,
        author, replies, reactions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult textMessage(
        String body,
        String id,
        String channelId,
        DateTime timestamp,
        int reportCount,
        Map<String, dynamic> author,
        List<String> replies,
        List<Map<String, dynamic>> reactions),
    TResult imageMessage(
        List<String> imageUrls,
        String id,
        String channelId,
        DateTime timestamp,
        int reportCount,
        Map<String, dynamic> author,
        List<String> replies,
        List<Map<String, dynamic>> reactions),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (imageMessage != null) {
      return imageMessage(imageUrls, id, channelId, timestamp, reportCount,
          author, replies, reactions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult textMessage(TextMessage value),
    @required TResult imageMessage(ImageMessage value),
  }) {
    assert(textMessage != null);
    assert(imageMessage != null);
    return imageMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult textMessage(TextMessage value),
    TResult imageMessage(ImageMessage value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (imageMessage != null) {
      return imageMessage(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$ImageMessageToJson(this)..['runtimeType'] = 'imageMessage';
  }
}

abstract class ImageMessage implements Message {
  const factory ImageMessage(
      {@required List<String> imageUrls,
      @required String id,
      @required String channelId,
      @required DateTime timestamp,
      @required int reportCount,
      @required Map<String, dynamic> author,
      List<String> replies,
      List<Map<String, dynamic>> reactions}) = _$ImageMessage;

  factory ImageMessage.fromJson(Map<String, dynamic> json) =
      _$ImageMessage.fromJson;

  List<String> get imageUrls;
  @override
  String get id;
  @override
  String get channelId;
  @override
  DateTime get timestamp;
  @override
  int get reportCount;
  @override
  Map<String, dynamic> get author;
  @override
  List<String> get replies;
  @override
  List<Map<String, dynamic>> get reactions;
  @override
  $ImageMessageCopyWith<ImageMessage> get copyWith;
}
