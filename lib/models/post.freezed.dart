// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
class _$PostTearOff {
  const _$PostTearOff();

// ignore: unused_element
  _Post call(
      {@required String id,
      @required String authorId,
      @required String authorName,
      @required DateTime postTime,
      bool likedByUser,
      String imageUrl,
      List<String> unlikedBy = const [],
      String avatarUrl,
      List<String> likedBy = const [],
      String body,
      int commentCount,
      int likeCount}) {
    return _Post(
      id: id,
      authorId: authorId,
      authorName: authorName,
      postTime: postTime,
      likedByUser: likedByUser,
      imageUrl: imageUrl,
      unlikedBy: unlikedBy,
      avatarUrl: avatarUrl,
      likedBy: likedBy,
      body: body,
      commentCount: commentCount,
      likeCount: likeCount,
    );
  }

// ignore: unused_element
  Post fromJson(Map<String, Object> json) {
    return Post.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Post = _$PostTearOff();

/// @nodoc
mixin _$Post {
  /// ID is generated from Firebase UID
  String get id;

  /// The Id of whoever made the post
  String get authorId;

  /// The full name of whoever made the post
  String get authorName;

  /// The time that the post was made
  DateTime get postTime;

  /// Determined during runtime and not stored in database.
  /// Used so like button is properly set up.
  bool get likedByUser;

  /// Url to an image, if the post has an image.
  /// TODO: Should be converted to List<String> to support multiple images?
  String get imageUrl;

  /// ID's of those who have liked the post then disliked. Once added an ID isn't removed.
  /// It is here so double likes don't send two notications.
  List<String> get unlikedBy;

  /// Url to the authors profile image
  String get avatarUrl;

  /// Id's of those who liked post, used during runtime to determined [likedByUser]
  List<String> get likedBy;

  /// The main text of the post, if it is included.
  String get body;

  /// Used to track number of comments made
  int get commentCount;

  /// Used to track number of likes
  int get likeCount;

  Map<String, dynamic> toJson();
  $PostCopyWith<Post> get copyWith;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String authorId,
      String authorName,
      DateTime postTime,
      bool likedByUser,
      String imageUrl,
      List<String> unlikedBy,
      String avatarUrl,
      List<String> likedBy,
      String body,
      int commentCount,
      int likeCount});
}

/// @nodoc
class _$PostCopyWithImpl<$Res> implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  final Post _value;
  // ignore: unused_field
  final $Res Function(Post) _then;

  @override
  $Res call({
    Object id = freezed,
    Object authorId = freezed,
    Object authorName = freezed,
    Object postTime = freezed,
    Object likedByUser = freezed,
    Object imageUrl = freezed,
    Object unlikedBy = freezed,
    Object avatarUrl = freezed,
    Object likedBy = freezed,
    Object body = freezed,
    Object commentCount = freezed,
    Object likeCount = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      authorName:
          authorName == freezed ? _value.authorName : authorName as String,
      postTime: postTime == freezed ? _value.postTime : postTime as DateTime,
      likedByUser:
          likedByUser == freezed ? _value.likedByUser : likedByUser as bool,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      unlikedBy:
          unlikedBy == freezed ? _value.unlikedBy : unlikedBy as List<String>,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      likedBy: likedBy == freezed ? _value.likedBy : likedBy as List<String>,
      body: body == freezed ? _value.body : body as String,
      commentCount:
          commentCount == freezed ? _value.commentCount : commentCount as int,
      likeCount: likeCount == freezed ? _value.likeCount : likeCount as int,
    ));
  }
}

/// @nodoc
abstract class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) then) =
      __$PostCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String authorId,
      String authorName,
      DateTime postTime,
      bool likedByUser,
      String imageUrl,
      List<String> unlikedBy,
      String avatarUrl,
      List<String> likedBy,
      String body,
      int commentCount,
      int likeCount});
}

/// @nodoc
class __$PostCopyWithImpl<$Res> extends _$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(_Post _value, $Res Function(_Post) _then)
      : super(_value, (v) => _then(v as _Post));

  @override
  _Post get _value => super._value as _Post;

  @override
  $Res call({
    Object id = freezed,
    Object authorId = freezed,
    Object authorName = freezed,
    Object postTime = freezed,
    Object likedByUser = freezed,
    Object imageUrl = freezed,
    Object unlikedBy = freezed,
    Object avatarUrl = freezed,
    Object likedBy = freezed,
    Object body = freezed,
    Object commentCount = freezed,
    Object likeCount = freezed,
  }) {
    return _then(_Post(
      id: id == freezed ? _value.id : id as String,
      authorId: authorId == freezed ? _value.authorId : authorId as String,
      authorName:
          authorName == freezed ? _value.authorName : authorName as String,
      postTime: postTime == freezed ? _value.postTime : postTime as DateTime,
      likedByUser:
          likedByUser == freezed ? _value.likedByUser : likedByUser as bool,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      unlikedBy:
          unlikedBy == freezed ? _value.unlikedBy : unlikedBy as List<String>,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      likedBy: likedBy == freezed ? _value.likedBy : likedBy as List<String>,
      body: body == freezed ? _value.body : body as String,
      commentCount:
          commentCount == freezed ? _value.commentCount : commentCount as int,
      likeCount: likeCount == freezed ? _value.likeCount : likeCount as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Post with DiagnosticableTreeMixin implements _Post {
  const _$_Post(
      {@required this.id,
      @required this.authorId,
      @required this.authorName,
      @required this.postTime,
      this.likedByUser,
      this.imageUrl,
      this.unlikedBy = const [],
      this.avatarUrl,
      this.likedBy = const [],
      this.body,
      this.commentCount,
      this.likeCount})
      : assert(id != null),
        assert(authorId != null),
        assert(authorName != null),
        assert(postTime != null),
        assert(unlikedBy != null),
        assert(likedBy != null);

  factory _$_Post.fromJson(Map<String, dynamic> json) =>
      _$_$_PostFromJson(json);

  @override

  /// ID is generated from Firebase UID
  final String id;
  @override

  /// The Id of whoever made the post
  final String authorId;
  @override

  /// The full name of whoever made the post
  final String authorName;
  @override

  /// The time that the post was made
  final DateTime postTime;
  @override

  /// Determined during runtime and not stored in database.
  /// Used so like button is properly set up.
  final bool likedByUser;
  @override

  /// Url to an image, if the post has an image.
  /// TODO: Should be converted to List<String> to support multiple images?
  final String imageUrl;
  @JsonKey(defaultValue: const [])
  @override

  /// ID's of those who have liked the post then disliked. Once added an ID isn't removed.
  /// It is here so double likes don't send two notications.
  final List<String> unlikedBy;
  @override

  /// Url to the authors profile image
  final String avatarUrl;
  @JsonKey(defaultValue: const [])
  @override

  /// Id's of those who liked post, used during runtime to determined [likedByUser]
  final List<String> likedBy;
  @override

  /// The main text of the post, if it is included.
  final String body;
  @override

  /// Used to track number of comments made
  final int commentCount;
  @override

  /// Used to track number of likes
  final int likeCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Post(id: $id, authorId: $authorId, authorName: $authorName, postTime: $postTime, likedByUser: $likedByUser, imageUrl: $imageUrl, unlikedBy: $unlikedBy, avatarUrl: $avatarUrl, likedBy: $likedBy, body: $body, commentCount: $commentCount, likeCount: $likeCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Post'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('authorId', authorId))
      ..add(DiagnosticsProperty('authorName', authorName))
      ..add(DiagnosticsProperty('postTime', postTime))
      ..add(DiagnosticsProperty('likedByUser', likedByUser))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('unlikedBy', unlikedBy))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('likedBy', likedBy))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('commentCount', commentCount))
      ..add(DiagnosticsProperty('likeCount', likeCount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Post &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.authorId, authorId) ||
                const DeepCollectionEquality()
                    .equals(other.authorId, authorId)) &&
            (identical(other.authorName, authorName) ||
                const DeepCollectionEquality()
                    .equals(other.authorName, authorName)) &&
            (identical(other.postTime, postTime) ||
                const DeepCollectionEquality()
                    .equals(other.postTime, postTime)) &&
            (identical(other.likedByUser, likedByUser) ||
                const DeepCollectionEquality()
                    .equals(other.likedByUser, likedByUser)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.unlikedBy, unlikedBy) ||
                const DeepCollectionEquality()
                    .equals(other.unlikedBy, unlikedBy)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.likedBy, likedBy) ||
                const DeepCollectionEquality()
                    .equals(other.likedBy, likedBy)) &&
            (identical(other.body, body) ||
                const DeepCollectionEquality().equals(other.body, body)) &&
            (identical(other.commentCount, commentCount) ||
                const DeepCollectionEquality()
                    .equals(other.commentCount, commentCount)) &&
            (identical(other.likeCount, likeCount) ||
                const DeepCollectionEquality()
                    .equals(other.likeCount, likeCount)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(authorId) ^
      const DeepCollectionEquality().hash(authorName) ^
      const DeepCollectionEquality().hash(postTime) ^
      const DeepCollectionEquality().hash(likedByUser) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(unlikedBy) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(likedBy) ^
      const DeepCollectionEquality().hash(body) ^
      const DeepCollectionEquality().hash(commentCount) ^
      const DeepCollectionEquality().hash(likeCount);

  @override
  _$PostCopyWith<_Post> get copyWith =>
      __$PostCopyWithImpl<_Post>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PostToJson(this);
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {@required String id,
      @required String authorId,
      @required String authorName,
      @required DateTime postTime,
      bool likedByUser,
      String imageUrl,
      List<String> unlikedBy,
      String avatarUrl,
      List<String> likedBy,
      String body,
      int commentCount,
      int likeCount}) = _$_Post;

  factory _Post.fromJson(Map<String, dynamic> json) = _$_Post.fromJson;

  @override

  /// ID is generated from Firebase UID
  String get id;
  @override

  /// The Id of whoever made the post
  String get authorId;
  @override

  /// The full name of whoever made the post
  String get authorName;
  @override

  /// The time that the post was made
  DateTime get postTime;
  @override

  /// Determined during runtime and not stored in database.
  /// Used so like button is properly set up.
  bool get likedByUser;
  @override

  /// Url to an image, if the post has an image.
  /// TODO: Should be converted to List<String> to support multiple images?
  String get imageUrl;
  @override

  /// ID's of those who have liked the post then disliked. Once added an ID isn't removed.
  /// It is here so double likes don't send two notications.
  List<String> get unlikedBy;
  @override

  /// Url to the authors profile image
  String get avatarUrl;
  @override

  /// Id's of those who liked post, used during runtime to determined [likedByUser]
  List<String> get likedBy;
  @override

  /// The main text of the post, if it is included.
  String get body;
  @override

  /// Used to track number of comments made
  int get commentCount;
  @override

  /// Used to track number of likes
  int get likeCount;
  @override
  _$PostCopyWith<_Post> get copyWith;
}
