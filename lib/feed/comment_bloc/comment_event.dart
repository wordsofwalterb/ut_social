part of 'comment_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => const [];
}

class CommentAdded extends CommentsEvent {
  final Map<String, dynamic> map;

  /// Map Requires atleast:
  ///   authorName
  ///   authorId
  ///   postId
  const CommentAdded(this.map);

  @override
  List<Object> get props => [map];
}

class CommentLiked extends CommentsEvent {
  final String id;

  const CommentLiked(this.id);

  @override
  List<Object> get props => [id];
}

class CommentsRefreshed extends CommentsEvent {}

class CommentsFetched extends CommentsEvent {}

class CommentUnliked extends CommentsEvent {
  final String id;

  const CommentUnliked(this.id);

  @override
  List<Object> get props => [id];
}

class CommentsSetup extends CommentsEvent {
  const CommentsSetup();

  @override
  List<Object> get props => [];
}
