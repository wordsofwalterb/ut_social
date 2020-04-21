import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Post extends Equatable {
  final String _postId, _authorId, _authorName, _body, _avatarUrl, _imageUrl;
  final DateTime _postTime;
  final int _commentCount, _likeCount;

  String get postId => _postId;
  String get imageUrl => _imageUrl;
  String get avatarUrl => _avatarUrl;
  String get authorId => _authorId;
  String get body => _body;
  String get authorName => _authorName;
  DateTime get postTime => _postTime;
  int get commentCount => _commentCount;
  int get likeCount => _likeCount;

  Post(
      {@required String postId,
      @required String authorId,
      @required String authorName,
      @required DateTime postTime,
      String imageUrl,
      String avatarUrl,
      String body,
      int commentCount,
      int likeCount})
      : assert(postId != null),
        assert(authorId != null),
        assert(authorName != null),
        assert(postTime != null),
        _imageUrl = imageUrl,
        _avatarUrl = avatarUrl,
        _postId = postId,
        _authorId = authorId,
        _authorName = authorName,
        _postTime = postTime,
        _body = body ?? '',
        _commentCount = commentCount ?? 0,
        _likeCount = likeCount ?? 0;

  Post copyWith(
      {String postId,
      String authorId,
      String authorName,
      String imageUrl,
      DateTime postTime,
      String body,
      String avatarUrl,
      int commentCount,
      int likeCount}) {
    return Post(
      postId: postId ?? this._postId,
      imageUrl: imageUrl ?? this._imageUrl,
      avatarUrl: avatarUrl ?? this._avatarUrl,
      authorId: authorId ?? this._authorId,
      authorName: authorName ?? this._authorName,
      postTime: postTime ?? this._postTime,
      body: body ?? this._body,
      commentCount: commentCount ?? this._commentCount,
      likeCount: likeCount ?? this._likeCount,
    );
  }

  factory Post.fromMap(Map<String, dynamic> map) {

    return Post(
        imageUrl: map['imageUrl'],
        postId: map['id'],
        avatarUrl: map['avatarUrl'],
        authorId: map['authorId'],
        authorName: map['authorName'],
        postTime: (map['postTime'] as Timestamp).toDate(),
        body: map['body'],
        commentCount: map['commentCount'],
        likeCount: map['likeCount']);
  }

  @override
  List<Object> get props => [
        _imageUrl,
        _postId,
        _avatarUrl,
        _authorId,
        _authorName,
        _postTime,
        _body,
        _commentCount,
        _likeCount
      ];
}
