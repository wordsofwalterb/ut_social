import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ut_social/core/blocs/user_bloc/user_bloc.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  final UserBloc authBloc;
  Student currentUser;
  StreamSubscription userBlocSubscription;

  PostBloc({this.postRepository, this.authBloc}) {
    userBlocSubscription = authBloc.listen((state) {
      if (state is UserAuthenticated) {
        currentUser = state.currentUser;
      }
      assert(currentUser != null);
    });
  }

  @override
  Future<void> close() {
    userBlocSubscription.cancel();
    return super.close();
  }

  @override
  PostInitial get initialState => PostInitial();

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    Stream<Transition<PostEvent, PostState>> Function(PostEvent) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return event is! PostsFetch && event is! PostLike;
    });
    final debounceStream = events.where((event) {
      return event is PostsFetch || event is PostLike;
    }).debounceTime(const Duration(milliseconds: 300));

    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    try {
      if (event is PostSetup) {
        yield* _mapPostSetupToState();
      }
      if (currentState is PostLoaded) {
        if (event is PostAdded) {
          yield* _mapPostAddedToState(event.body, currentState, event.imageUrl);
        }
        if (event is PostsFetch && !_hasReachedMax(currentState)) {
          yield* _mapPostFetchToState(currentState);
        }
        if (event is PostRefresh) {
          yield* _mapPostRefreshToState(currentState);
        }
        if (event is PostLike) {
          yield* _mapPostLikeToState(currentState, event.postId);
        }
        if (event is PostUnlike) {
          yield* _mapPostUnlikeToState(currentState, event.postId);
        } else if (event is PostCommentRemoved) {
          yield* _mapPostCommentRemovedToState(event.postId);
        } else if (event is PostCommentAdded) {
          yield* _mapPostCommentAddedToState(event.postId);
        }
      }
    } catch (_) {
      yield PostError();
    }
  }

  Stream<PostState> _mapPostCommentAddedToState(String postId) async* {
    final currentState = state;
    if (currentState is PostLoaded) {
      await postRepository.updateCommentCount(postId, 1);
      final changedPostIndex =
          currentState.posts.indexWhere((element) => element.id == postId);

      final changedPosts = currentState.posts.toList()
        ..[changedPostIndex] = currentState.posts[changedPostIndex].copyWith(
            commentCount:
                currentState.posts[changedPostIndex].commentCount + 1);

      yield currentState.copyWith(posts: changedPosts);
    }
  }

  Stream<PostState> _mapPostCommentRemovedToState(String postId) async* {
    final currentState = state;
    if (currentState is PostLoaded) {
      await postRepository.updateCommentCount(postId, -1);
      final changedPostIndex =
          currentState.posts.indexWhere((element) => element.id == postId);

      final changedPosts = currentState.posts.toList()
        ..[changedPostIndex] = currentState.posts[changedPostIndex].copyWith(
            commentCount:
                currentState.posts[changedPostIndex].commentCount - 1);

      yield currentState.copyWith(posts: changedPosts);
    }
  }

  Stream<PostState> _mapPostAddedToState(
      String body, PostLoaded currentState, String imageUrl) async* {
    assert(body != null);

    final post = await postRepository.addPost(
        currentUser, body, imageUrl); // TODO: Add Try Catch

    final newState = currentState.copyWith(
        firstPostTime: post.postTime,
        posts: currentState.posts.toList()..insert(0, post));

    assert(newState != currentState);

    yield newState;
  }

  Stream<PostState> _mapPostRefreshToState(PostLoaded currentState) async* {
    final posts = await postRepository.setupFeed();

    yield PostLoaded(
        posts: posts,
        hasReachedMax: false,
        isRefreshed: true,
        lastPostTime: posts?.last?.postTime,
        firstPostTime: posts?.first?.postTime);
  }

  Stream<PostState> _mapPostLikeToState(
      PostLoaded currentState, String postId) async* {
    final userState = authBloc.state;
    if (userState is UserAuthenticated) {
      // Find changed post and add like
      final initialPost =
          currentState.posts.firstWhere((val) => val.id == postId);
      final newLikedBy = initialPost.likedBy.toList();
      newLikedBy.addAll([userState.currentUser.id]);
      final changedPost = initialPost.copyWith(
          likeCount: initialPost.likeCount + 1, likedBy: newLikedBy);

      // Propagate to database

      await postRepository.likePost(postId, userState.currentUser.id);

      final newPosts = currentState.posts.toList();

      newPosts.removeWhere((val) => val.id == postId);
      newPosts.add(changedPost);

      final newState = currentState.copyWith(
        posts: newPosts,
        lastPostLiked: postId,
      );

      assert(newState != currentState);
      // Yield new version of posts
      yield newState;
    }
  }

  Stream<PostState> _mapPostUnlikeToState(
      PostLoaded currentState, String postId) async* {
    final userState = authBloc.state;
    if (userState is UserAuthenticated) {
      // Find changed post and unlike
      final initialPost =
          currentState.posts.firstWhere((val) => val.id == postId);
      final newLikedBy = initialPost.likedBy.toList();
      newLikedBy.removeWhere((i) => i == userState.currentUser.id);
      final changedPost = initialPost.copyWith(
          likeCount: initialPost.likeCount - 1, likedBy: newLikedBy);

      // Propagate to database

      await postRepository.unlikePost(postId, userState.currentUser.id);

      print(changedPost.likeCount);
      final newState = currentState.copyWith(
          lastPostLiked: postId,
          posts: currentState.posts.toList()
            ..removeWhere((val) => val.id == postId)
            ..add(changedPost));

      // Yield new version of posts
      yield newState;
    }
  }

  Stream<PostState> _mapPostFetchToState(PostLoaded currentState) async* {
    final posts = await postRepository.fetchNextPage(
        startAfter: currentState.lastPostTime, limit: 5);

    yield posts.isEmpty
        ? currentState.copyWith(hasReachedMax: true, loadingMore: true)
        : PostLoaded(
            posts: posts.toList()
              ..addAll(currentState.posts)
              ..sort((a, b) => b.postTime.compareTo(a.postTime)),
            hasReachedMax: false,
            lastPostLiked: currentState.lastPostLiked,
            loadingMore: true,
            lastPostTime: posts.last.postTime,
            firstPostTime: posts.first.postTime,
          );
  }

  Stream<PostState> _mapPostSetupToState() async* {
    final posts = await postRepository.setupFeed();

    yield PostLoaded(
      posts: posts..sort((a, b) => b.postTime.compareTo(a.postTime)),
      hasReachedMax: posts.length <= 20,
      isRefreshed: true,
      lastPostTime: (posts.isNotEmpty) ? posts.last.postTime : null,
      firstPostTime: (posts.isNotEmpty) ? posts.first.postTime : null,
    );
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;
}
