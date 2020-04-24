part of 'post_bloc.dart';


abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  const PostLoaded({
    this.posts,
    this.hasReachedMax,
  });

  PostLoaded copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}

class PostError extends PostState {}