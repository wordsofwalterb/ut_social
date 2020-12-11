// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
class _$CommentTearOff {
  const _$CommentTearOff();

// ignore: unused_element
  _Comment call(
      {@required String id,
      @required String postId,
      @required String authorId,
      @required String authorName,
      @required String authorAvatar,
      @required DateTime timestamp,
      @required bool likedByUser,
      int likeCount = 0,
      List<String> likedBy = const [],
      List<String> unlikedBy = const [],
      String imageUrl,
      String body,
      int reportCount = 0,
      List<String> reportedBy = const [],
      bool isBanned = false}) {
    return _Comment(
      id: id,
      postId: postId,
      authorId: authorId,
      authorName: authorName,
      authorAvatar: authorAvatar,
      timestamp: timestamp,
      likedByUser: likedByUser,
      likeCount: likeCount,
      likedBy: likedBy,
      unlikedBy: unlikedBy,
      imageUrl: imageUrl,
      body: body,
      reportCount: reportCount,
      reportedBy: reportedBy,
      isBanned: isBanned,
    );
  }

// ignore: unused_element
  Comment fromJson(Map<String, Object> json) {
    return Comment.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Comment = _$CommentTearOff();

/// @nodoc
mixin _$Comment {
  String get id;
  String get postId;
  String get authorId;
  String get authorName;
  String get authorAvatar;
  DateTime get timestamp;
  bool get likedByUser;
  int get likeCount;
  List<String> get likedBy;
  List<String> get unlikedBy;
  String get imageUrl;
  String get body;
  int get reportCount;
  List<String> get reportedBy;
  bool get isBanned;

  Map<String, dynamic> toJson();
  $CommentCopyWith<Comment> get copyWith;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String postId,
      String authorId,
      String authorName,
      String authorAvatar,
      DateTime timestamp,
      bool likedByUser,
      int likeCount,
      List<String> likedBy,
      List<String> unlikedBy,
      String imageUrl,
      String body,
      int reportCount,
      List<String> reportedBy,
      bool isBanned});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res> implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  final Comment _value;
  // ignore: unused_field
  final $Res Function(Comment) _then;

  @override
  $Res call({
    Object id = freezed,
    Object postId = freezed,
    Object authorId = freezed,
    Object authorName = freezed,
    Object authorAvatar = freezed,
    Object timestamp = freezed,
    Object likedByUser = freezed,
    Object likeCount = freezed,
    Object likedBy = freezed,
    Object unlikedBy = freezed,
    Object imageUrl = freezed,
    Object body = freezed,
    Object reportCount = freezed,
    Object reportedBy = freezed,
    Object isBanned = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      postId: postId == freezed ? _value.postId : postId as String,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      authorName:
          authorName == freezed ? _value.authorName : authorName as String,
      authorAvatar: authorAvatar == freezed
          ? _value.authorAvatar
          : authorAvatar as String,
      timestamp:
          timestamp == freezed ? _value.timestamp : timestamp as DateTime,
      likedByUser:
          likedByUser == freezed ? _value.likedByUser : likedByUser as bool,
      likeCount: likeCount == freezed ? _value.likeCount : likeCount as int,
      likedBy: likedBy == freezed ? _value.likedBy : likedBy as List<String>,
      unlikedBy:
          unlikedBy == freezed ? _value.unlikedBy : unlikedBy as List<String>,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      body: body == freezed ? _value.body : body as String,
      reportCount:
          reportCount == freezed ? _value.reportCount : reportCount as int,
      reportedBy: reportedBy == freezed
          ? _value.reportedBy
          : reportedBy as List<String>,
      isBanned: isBanned == freezed ? _value.isBanned : isBanned as bool,
    ));
  }
}

/// @nodoc
abstract class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) then) =
      __$CommentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String postId,
      String authorId,
      String authorName,
      String authorAvatar,
      DateTime timestamp,
      bool likedByUser,
      int likeCount,
      List<String> likedBy,
      List<String> unlikedBy,
      String imageUrl,
      String body,
      int reportCount,
      List<String> reportedBy,
      bool isBanned});
}

/// @nodoc
class __$CommentCopyWithImpl<$Res> extends _$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(_Comment _value, $Res Function(_Comment) _then)
      : super(_value, (v) => _then(v as _Comment));

  @override
  _Comment get _value => super._value as _Comment;

  @override
  $Res call({
    Object id = freezed,
    Object postId = freezed,
    Object authorId = freezed,
    Object authorName = freezed,
    Object authorAvatar = freezed,
    Object timestamp = freezed,
    Object likedByUser = freezed,
    Object likeCount = freezed,
    Object likedBy = freezed,
    Object unlikedBy = freezed,
    Object imageUrl = freezed,
    Object body = freezed,
    Object reportCount = freezed,
    Object reportedBy = freezed,
    Object isBanned = freezed,
  }) {
    return _then(_Comment(
      id: id == freezed ? _value.id : id as String,
      postId: postId == freezed ? _value.postId : postId as String,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      authorName:
          authorName == freezed ? _value.authorName : authorName as String,
      authorAvatar: authorAvatar == freezed
          ? _value.authorAvatar
          : authorAvatar as String,
      timestamp:
          timestamp == freezed ? _value.timestamp : timestamp as DateTime,
      likedByUser:
          likedByUser == freezed ? _value.likedByUser : likedByUser as bool,
      likeCount: likeCount == freezed ? _value.likeCount : likeCount as int,
      likedBy: likedBy == freezed ? _value.likedBy : likedBy as List<String>,
      unlikedBy:
          unlikedBy == freezed ? _value.unlikedBy : unlikedBy as List<String>,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      body: body == freezed ? _value.body : body as String,
      reportCount:
          reportCount == freezed ? _value.reportCount : reportCount as int,
      reportedBy: reportedBy == freezed
          ? _value.reportedBy
          : reportedBy as List<String>,
      isBanned: isBanned == freezed ? _value.isBanned : isBanned as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Comment with DiagnosticableTreeMixin implements _Comment {
  const _$_Comment(
      {@required this.id,
      @required this.postId,
      @required this.authorId,
      @required this.authorName,
      @required this.authorAvatar,
      @required this.timestamp,
      @required this.likedByUser,
      this.likeCount = 0,
      this.likedBy = const [],
      this.unlikedBy = const [],
      this.imageUrl,
      this.body,
      this.reportCount = 0,
      this.reportedBy = const [],
      this.isBanned = false})
      : assert(id != null),
        assert(postId != null),
        assert(authorId != null),
        assert(authorName != null),
        assert(authorAvatar != null),
        assert(timestamp != null),
        assert(likedByUser != null),
        assert(likeCount != null),
        assert(likedBy != null),
        assert(unlikedBy != null),
        assert(reportCount != null),
        assert(reportedBy != null),
        assert(isBanned != null);

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$_$_CommentFromJson(json);

  @override
  final String id;
  @override
  final String postId;
  @override
  final String authorId;
  @override
  final String authorName;
  @override
  final String authorAvatar;
  @override
  final DateTime timestamp;
  @override
  final bool likedByUser;
  @JsonKey(defaultValue: 0)
  @override
  final int likeCount;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> likedBy;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> unlikedBy;
  @override
  final String imageUrl;
  @override
  final String body;
  @JsonKey(defaultValue: 0)
  @override
  final int reportCount;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> reportedBy;
  @JsonKey(defaultValue: false)
  @override
  final bool isBanned;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Comment(id: $id, postId: $postId, authorId: $authorId, authorName: $authorName, authorAvatar: $authorAvatar, timestamp: $timestamp, likedByUser: $likedByUser, likeCount: $likeCount, likedBy: $likedBy, unlikedBy: $unlikedBy, imageUrl: $imageUrl, body: $body, reportCount: $reportCount, reportedBy: $reportedBy, isBanned: $isBanned)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Comment'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('postId', postId))
      ..add(DiagnosticsProperty('authorId', authorId))
      ..add(DiagnosticsProperty('authorName', authorName))
      ..add(DiagnosticsProperty('authorAvatar', authorAvatar))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('likedByUser', likedByUser))
      ..add(DiagnosticsProperty('likeCount', likeCount))
      ..add(DiagnosticsProperty('likedBy', likedBy))
      ..add(DiagnosticsProperty('unlikedBy', unlikedBy))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('reportCount', reportCount))
      ..add(DiagnosticsProperty('reportedBy', reportedBy))
      ..add(DiagnosticsProperty('isBanned', isBanned));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Comment &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.postId, postId) ||
                const DeepCollectionEquality().equals(other.postId, postId)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.authorName, authorName) ||
                const DeepCollectionEquality()
                    .equals(other.authorName, authorName)) &&
            (identical(other.authorAvatar, authorAvatar) ||
                const DeepCollectionEquality()
                    .equals(other.authorAvatar, authorAvatar)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.likedByUser, likedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.likedByUser, likedByUser)) &&
            (identical(other.likeCount, likeCount) ||
                const DeepCollectionEquality()
                    .equals(other.likeCount, likeCount)) &&
            (identical(other.likedBy, likedBy) ||
                const DeepCollectionEquality()
                    .equals(other.likedBy, likedBy)) &&
            (identical(other.unlikedBy, unlikedBy) ||
                const DeepCollectionEquality()
                    .equals(other.unlikedBy, unlikedBy)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.reportCount, reportCount) ||
                const DeepCollectionEquality()
                    .equals(other.reportCount, reportCount)) &&
            (identical(other.reportedBy, reportedBy) ||
                const DeepCollectionEquality()
                    .equals(other.reportedBy, reportedBy)) &&
            (identical(other.isBanned, isBanned) ||
                const DeepCollectionEquality()
                    .equals(other.isBanned, isBanned)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(postId) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(authorName) ^
      const DeepCollectionEquality().hash(authorAvatar) ^
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(likedByUser) ^
      const DeepCollectionEquality().hash(likeCount) ^
      const DeepCollectionEquality().hash(likedBy) ^
      const DeepCollectionEquality().hash(unlikedBy) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(reportCount) ^
      const DeepCollectionEquality().hash(reportedBy) ^
      const DeepCollectionEquality().hash(isBanned);

  @override
  _$CommentCopyWith<_Comment> get copyWith =>
      __$CommentCopyWithImpl<_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CommentToJson(this);
  }
}

abstract class _Comment implements Comment {
  const factory _Comment(
      {@required String id,
      @required String postId,
      @required String authorId,
      @required String authorName,
      @required String authorAvatar,
      @required DateTime timestamp,
      @required bool likedByUser,
      int likeCount,
      List<String> likedBy,
      List<String> unlikedBy,
      String imageUrl,
      String body,
      int reportCount,
      List<String> reportedBy,
      bool isBanned}) = _$_Comment;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  String get id;
  @override
  String get postId;
  @override
  String get authorId;
  @override
  String get authorName;
  @override
  String get authorAvatar;
  @override
  DateTime get timestamp;
  @override
  bool get likedByUser;
  @override
  int get likeCount;
  @override
  List<String> get likedBy;
  @override
  List<String> get unlikedBy;
  @override
  String get imageUrl;
  @override
  String get body;
  @override
  int get reportCount;
  @override
  List<String> get reportedBy;
  @override
  bool get isBanned;
  @override
  _$CommentCopyWith<_Comment> get copyWith;
}
