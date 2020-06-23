part of 'post_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => const [];
}

class AddPost extends PostsEvent {
  final String body;
  final String imageUrl;
  final Student author;

  const AddPost(this.body, this.imageUrl, this.author);

  @override
  List<Object> get props => [body, imageUrl, author];
}

class IncrementCommentCount extends PostsEvent {
  final String id;

  const IncrementCommentCount(this.id);

  @override
  List<Object> get props => [id];
}

class DecrementCommentCount extends PostsEvent {
  final String id;

  const DecrementCommentCount(this.id);

  @override
  List<Object> get props => [id];
}

class RefreshPosts extends PostsEvent {}

class DeletePost extends PostsEvent {
  final Post post;

  const DeletePost(this.post);

  @override
  List<Object> get props => [post];
}

class FetchPosts extends PostsEvent {}

class LikePost extends PostsEvent {
  final String id;

  const LikePost(this.id);

  @override
  List<Object> get props => [id];
}

class UnlikePost extends PostsEvent {
  final String id;

  const UnlikePost(this.id);

  @override
  List<Object> get props => [id];
}

class SetupPosts extends PostsEvent {
  const SetupPosts();

  @override
  List<Object> get props => [];
}
