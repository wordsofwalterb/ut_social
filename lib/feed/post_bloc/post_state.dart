part of 'post_bloc.dart';

abstract class PostsState extends Equatable {
  List<Post> get posts;

  const PostsState();

  PostsState copyWith({List<Post> posts});
}

class PostsInitial extends PostsState {
  @override
  final List<Post> posts = //ignore: avoid_field_initializers_in_const_classes
      const [];

  const PostsInitial();

  @override
  List<Object> get props => [posts];

  @override
  PostsInitial copyWith({List<Post> posts}) {
    return PostsInitial();
  }
}

class PostsError extends PostsState {
  @override
  final List<Post> posts;
  final Failure failure;

  const PostsError({@required this.failure, this.posts});

  @override
  PostsError copyWith({String postId, List<Post> posts, Failure failure}) {
    return PostsError(
        posts: posts ?? this.posts, failure: failure ?? this.failure);
  }

  @override
  List<Object> get props => [failure, posts];
}

class PostsEmpty extends PostsState {
  @override
  final List<Post> posts = const [];

  const PostsEmpty();

  @override
  PostsEmpty copyWith({List<Post> posts}) {
    return PostsEmpty();
  }

  @override
  List<Object> get props => [posts];
}

class PostsReachedMax extends PostsState {
  @override
  final List<Post> posts;

  const PostsReachedMax({
    @required this.posts,
  });

  @override
  PostsReachedMax copyWith({
    List<Post> posts,
  }) {
    return PostsReachedMax(
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [posts];
}

class PostsLoaded extends PostsState {
  @override
  final List<Post> posts;

  const PostsLoaded({
    @required this.posts,
  });

  @override
  PostsLoaded copyWith({
    List<Post> posts,
  }) {
    return PostsLoaded(
      posts: posts ?? this.posts,
    );
  }

  @override
  List<Object> get props => [posts];
}
