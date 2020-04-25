part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentError extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentLoaded extends CommentState {
  final String postId;
  final List<Comment> comments;

  CommentLoaded({this.postId, this.comments});

  @override
  List<Object> get props => [postId, comments];

  @override
  String toString() => 'postId: $postId, comments: ${comments.length}';
}
