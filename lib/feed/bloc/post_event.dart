part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostsFetch extends PostEvent {}

class PostLike extends PostEvent {
  final String postId;

  const PostLike(this.postId);

  @override
  List<Object> get props => [postId];
}

class PostUnlike extends PostEvent {
  final String postId;

  const PostUnlike(this.postId);

  @override
  List<Object> get props => [postId];
}

class PostSetup extends PostEvent {}
