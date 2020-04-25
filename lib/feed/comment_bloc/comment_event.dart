part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => const [];
}

class CommentAdded extends CommentEvent {
  final String body;

  CommentAdded(this.body);

  @override
  List<Object> get props => [body];
}

class CommentLiked extends CommentEvent {}

class CommentSetup extends CommentEvent {
  final String postId;

  CommentSetup(this.postId);

  @override
  List<Object> get props => [postId];
}

class CommentUnliked extends CommentEvent {}
