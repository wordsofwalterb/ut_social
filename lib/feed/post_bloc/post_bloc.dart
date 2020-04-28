import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/feed/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  final AuthenticationBloc authBloc;
  Student currentUser;
  StreamSubscription authBlocSubscription;

  PostBloc({this.postRepository, this.authBloc}) {
    authBlocSubscription = authBloc.listen((state) {
      if (state is AuthAuthenticated) {
        currentUser = state.currentUser;
      }
      assert(currentUser != null);
    });
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }

  @override
  get initialState => PostInitial();

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    events,
    next,
  ) {
    var nonDebounceStream = events.where((event) {
      return (event is! PostsFetch && event is! PostLike);
    });
    var debounceStream = events.where((event) {
      return (event is PostsFetch || event is PostLike);
    }).debounceTime(Duration(milliseconds: 300));

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
        }
      }
    } catch (_) {
      yield PostError();
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
    final posts =
        await postRepository.retrieveLatestPosts(currentState.lastPostTime);

    yield PostLoaded(
        posts: posts.toList()
          ..addAll(currentState.posts)
          ..sort((a, b) => b.postTime.compareTo(a.postTime)),
        hasReachedMax: false,
        isRefreshed: true,
        lastPostTime: posts.last.postTime,
        firstPostTime: posts.first.postTime);
  }

  Stream<PostState> _mapPostLikeToState(
      PostLoaded currentState, String postId) async* {
    var authState = authBloc.state;
    if (authState is AuthAuthenticated) {
      // Find changed post and add like
      var initialPost =
          currentState.posts.firstWhere((val) => val.id == postId);
      var newLikedBy = initialPost.likedBy.toList();
      newLikedBy.addAll([authState.currentUser.id]);
      var changedPost = initialPost.copyWith(
          likeCount: initialPost.likeCount + 1, likedBy: newLikedBy);

      // Propagate to database

      await postRepository.likePost(postId, authState.currentUser.id);

      var newPosts = currentState.posts.toList();

      newPosts.removeWhere((val) => val.id == postId);
      newPosts.add(changedPost);

      var newState = currentState.copyWith(
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
    var authState = authBloc.state;
    if (authState is AuthAuthenticated) {
      // Find changed post and unlike
      var initialPost =
          currentState.posts.firstWhere((val) => val.id == postId);
      var newLikedBy = initialPost.likedBy.toList();
      newLikedBy.removeWhere((i) => i == authState.currentUser.id);
      var changedPost = initialPost.copyWith(
          likeCount: initialPost.likeCount - 1, likedBy: newLikedBy);

      // Propagate to database

      await postRepository.unlikePost(postId, authState.currentUser.id);

      print(changedPost.likeCount);
      var newState = currentState.copyWith(
          lastPostLiked: postId,
          posts: currentState.posts.toList()
            ..removeWhere((val) => val.id == postId)
            ..add(changedPost));

      // Yield new version of posts
      yield newState;
    }
  }

  Stream<PostState> _mapPostFetchToState(PostLoaded currentState) async* {
    var posts = await postRepository.fetchNextPage(
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
      hasReachedMax: (posts.length <= 20) ? true : false,
      isRefreshed: true,
      lastPostTime: (posts.isNotEmpty) ? posts.last.postTime : null,
      firstPostTime: (posts.isNotEmpty) ? posts.first.postTime : null,
    );
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;
}
