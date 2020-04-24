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
  final String lastPostLiked;
  final bool loadingMore;
  final bool isRefreshed;
  final DateTime lastPostTime;
  final DateTime firstPostTime;

  const PostLoaded({
    this.lastPostTime,
    this.lastPostLiked,
    this.firstPostTime,
    this.posts,
    this.isRefreshed,
    this.hasReachedMax,
    this.loadingMore,
  });

  PostLoaded copyWith({
    List<Post> posts,
    bool hasReachedMax,
    DateTime lastPostTime,
    String lastPostLiked,
    bool isRefreshed,
    DateTime firstPostTime,
    bool loadingMore,
  }) {
    return PostLoaded(
      firstPostTime: firstPostTime?? this.firstPostTime,
      lastPostTime: lastPostTime ?? this.lastPostTime,
      loadingMore: loadingMore ?? false,
      isRefreshed: isRefreshed ?? false,
      lastPostLiked: lastPostLiked ?? this.lastPostLiked,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax, lastPostLiked, loadingMore, isRefreshed,lastPostTime,firstPostTime];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax, lastPostLiked: $lastPostLiked, loadingMore $loadingMore, isRefreshed: $isRefreshed, lastPostTime: $lastPostTime, firstPostTime: $firstPostTime}';
}

class PostError extends PostState {}
