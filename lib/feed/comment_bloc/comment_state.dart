part of 'comment_bloc.dart';

abstract class CommentsState extends Equatable {
  String get postId;
  List<Comment> get comments;

  const CommentsState();

  CommentsState copyWith({String postId, List<Comment> comments});
}

class CommentsInitial extends CommentsState {
  @override
  final String postId;
  @override
  final List<Comment>
      comments = //ignore: avoid_field_initializers_in_const_classes
      const [];

  const CommentsInitial({@required this.postId});

  @override
  List<Object> get props => [postId, comments];

  @override
  CommentsInitial copyWith({String postId, List<Comment> comments}) {
    return CommentsInitial(
      postId: postId ?? this.postId,
    );
  }
}

class CommentsError extends CommentsState {
  @override
  final String postId;
  @override
  final List<Comment> comments;
  final Failure failure;

  const CommentsError(
      {@required this.failure, @required this.postId, this.comments});

  @override
  CommentsError copyWith(
      {String postId, List<Comment> comments, Failure failure}) {
    return CommentsError(
        postId: postId ?? this.postId,
        comments: comments ?? this.comments,
        failure: failure ?? this.failure);
  }

  @override
  List<Object> get props => [failure, postId, comments];
}

class CommentsEmpty extends CommentsState {
  @override
  final String postId;
  @override
  final List<Comment>
      comments = //ignore: avoid_field_initializers_in_const_classes

      const [];
  const CommentsEmpty({
    @required this.postId,
  });

  @override
  CommentsEmpty copyWith({String postId, List<Comment> comments}) {
    return CommentsEmpty(postId: postId ?? this.postId);
  }

  @override
  List<Object> get props => [postId, comments];
}

class CommentsReachedMax extends CommentsState {
  @override
  final String postId;
  @override
  final List<Comment> comments;

  const CommentsReachedMax({
    @required this.postId,
    @required this.comments,
  });

  @override
  CommentsReachedMax copyWith({
    List<Comment> comments,
    String postId,
  }) {
    return CommentsReachedMax(
      postId: postId ?? this.postId,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object> get props => [postId, comments];
}

class CommentsLoaded extends CommentsState {
  @override
  final String postId;
  @override
  final List<Comment> comments;

  const CommentsLoaded({
    @required this.postId,
    @required this.comments,
  });

  @override
  CommentsLoaded copyWith({
    String postId,
    List<Comment> comments,
  }) {
    return CommentsLoaded(
      postId: postId ?? this.postId,
      comments: comments ?? this.comments,
    );
  }

  @override
  List<Object> get props => [postId, comments];
}
