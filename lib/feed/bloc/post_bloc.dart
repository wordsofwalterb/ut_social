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
    final debounceStream = events.debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(debounceStream, next);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    try {
      if (event is PostSetup) {
        yield* _mapPostSetupToState();
      }
      if (currentState is PostLoaded) {
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

  Stream<PostState> _mapPostRefreshToState(PostLoaded currentState) async* {}

  Stream<PostState> _mapPostLikeToState(
      PostLoaded currentState, String postId) async* {
    // Find changed post and add like
    var initialPost =
        currentState.posts.firstWhere((val) => val.postId == postId);
    var changedPost = initialPost.copyWith(likeCount: initialPost.likeCount + 1);

    // Propagate to database
    authBloc.add(AuthLikedPost(changedPost.postId));
    await postRepository.likePost(postId);

    // Yield new version of posts
    yield currentState.copyWith(
        posts: currentState.posts
          ..removeWhere((val) => val.postId == postId)
          ..add(changedPost));

  }

  Stream<PostState> _mapPostUnlikeToState(
      PostLoaded currentState, String postId) async* {
    // Find changed post and unlike
    var initialPost =
        currentState.posts.firstWhere((val) => val.postId == postId);
    var changedPost = initialPost.copyWith(likeCount: initialPost.likeCount - 1);

    // Propagate to database
    authBloc.add(AuthDislikePost(changedPost.postId));
    await postRepository.unlikePost(postId);

    // Yield new version of posts
    yield currentState.copyWith(
        posts: currentState.posts
          ..removeWhere((val) => val.postId == postId)
          ..add(changedPost));
  }

  Stream<PostState> _mapPostFetchToState(PostLoaded currentState) async* {


    var posts = await postRepository.fetchNextPage(
        startAfter: currentState.posts.last.postTime);

    posts.sort((a,b) => b.postTime.compareTo(a.postTime));
    yield posts.isEmpty
        ? currentState.copyWith(hasReachedMax: true)
        : PostLoaded(
            posts: currentState.posts + posts,
            hasReachedMax: false,
          );
  }

  Stream<PostState> _mapPostSetupToState() async* {
    final posts = await postRepository.setupFeed();
    yield PostLoaded(posts: posts, hasReachedMax: false);
    return;
  }

  int likeCount(String postId, PostLoaded state) {
    return state.posts.firstWhere((e) => e.postId == postId).likeCount;
  }

  bool isLiked(String postId) {
    return currentUser.likedPosts.contains(postId);
  }


  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;
}
