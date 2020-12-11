import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/foundation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  /// Used to store all relevant data needed to construct a [PostCard] widget
  const factory Post(
      {

      /// ID is generated from Firebase UID
      @required String id,

      /// The Id of whoever made the post
      @required String authorId,

      /// The full name of whoever made the post
      @required String authorName,

      /// The time that the post was made
      @required DateTime postTime,

      /// Determined during runtime and not stored in database.
      /// Used so like button is properly set up.
      bool likedByUser,

      /// Url to an image, if the post has an image.
      /// TODO: Should be converted to List<String> to support multiple images?
      String imageUrl,

      /// ID's of those who have liked the post then disliked. Once added an ID isn't removed.
      /// It is here so double likes don't send two notications.
      @Default([]) List<String> unlikedBy,

      /// Url to the authors profile image
      String avatarUrl,

      /// Id's of those who liked post, used during runtime to determined [likedByUser]
      @Default([]) List<String> likedBy,

      /// The main text of the post, if it is included.
      String body,

      /// Used to track number of comments made
      int commentCount,

      /// Used to track number of likes
      int likeCount}) = _Post;

  /// Converts a map of items with same variable name (key) and type for value
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
