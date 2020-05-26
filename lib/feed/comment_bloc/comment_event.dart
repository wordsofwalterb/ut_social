part of 'comment_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object> get props => const [];
}

class AddComment extends CommentsEvent {
  final Map<String, dynamic> map;

  /// Map Requires atleast:
  ///   authorName
  ///   authorId
  ///   postId
  const AddComment(this.map);

  @override
  List<Object> get props => [map];
}

class LikeComment extends CommentsEvent {
  final String id;

  const LikeComment(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshComments extends CommentsEvent {}

class FetchComments extends CommentsEvent {}

class UnlikeComment extends CommentsEvent {
  final String id;

  const UnlikeComment(this.id);

  @override
  List<Object> get props => [id];
}

class SetupComments extends CommentsEvent {
  const SetupComments();

  @override
  List<Object> get props => [];
}
