import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/failure.dart';
import 'package:ut_social/models/post.dart';
import 'package:collection/collection.dart';
import 'package:ut_social/models/student.dart';
import 'package:ut_social/services/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  PostsBloc({
    this.postRepository,
  }) : super(const PostsInitial());

  final PostRepository postRepository;

  @override
  Stream<PostsState> mapEventToState(
    PostsEvent event,
  ) async* {
    final currentState = state;
    if (currentState is PostsInitial) {
      if (event is SetupPosts) {
        yield* _mapPostSetupToState();
      }
    }
    if (currentState is PostsError) {
      if (event is RefreshPosts) {
        yield* _mapPostsRefreshedToState();
      }
    }
    if (currentState is PostsEmpty) {
      if (event is RefreshPosts) {
        yield* _mapPostsRefreshedToState();
      } else if (event is AddPost) {
        yield* _mapPostAddedToState(event);
      }
    }
    if (currentState is PostsReachedMax) {
      if (event is AddPost) {
        yield* _mapPostAddedToState(event);
      } else if (event is LikePost) {
        yield* _mapPostLikedToState(event);
      } else if (event is UnlikePost) {
        yield* _mapPostUnlikedToState(event);
      } else if (event is RefreshPosts) {
        yield* _mapPostsRefreshedToState();
      } else if (event is IncrementCommentCount) {
        yield* _mapIncrementCommentCountToState(event);
      } else if (event is DecrementCommentCount) {
        yield* _mapDecrementCommentCountToState(event);
      } else if (event is DeletePost) {
        yield* _mapDeletePostToState(event);
      }
    }
    if (currentState is PostsLoaded) {
      if (event is AddPost) {
        yield* _mapPostAddedToState(event);
      } else if (event is LikePost) {
        yield* _mapPostLikedToState(event);
      } else if (event is UnlikePost) {
        yield* _mapPostUnlikedToState(event);
      } else if (event is RefreshPosts) {
        yield* _mapPostsRefreshedToState();
      } else if (event is FetchPosts) {
        yield* _mapPostsFetchedToState();
      } else if (event is IncrementCommentCount) {
        yield* _mapIncrementCommentCountToState(event);
      } else if (event is DecrementCommentCount) {
        yield* _mapDecrementCommentCountToState(event);
      } else if (event is DeletePost) {
        yield* _mapDeletePostToState(event);
      }
    }
  }

  Stream<PostsState> _mapDeletePostToState(DeletePost event) async* {
    final currentState = state;
    if (currentState is PostsLoaded || currentState is PostsReachedMax) {
      final newPosts = currentState.posts.toList();
      newPosts.remove(event.post);
      yield currentState.copyWith(posts: newPosts);
    }
    await postRepository.deletePost(event.post.id);
  }

  Stream<PostsState> _mapIncrementCommentCountToState(
      IncrementCommentCount event) async* {
    final currentState = state;
    if (currentState is PostsLoaded || currentState is PostsReachedMax) {
      await postRepository.updateCommentCount(event.id, 1);
      final changedPostIndex =
          currentState.posts.indexWhere((element) => element.id == event.id);

      final changedPosts = currentState.posts.toList()
        ..[changedPostIndex] = currentState.posts[changedPostIndex].copyWith(
            commentCount:
                currentState.posts[changedPostIndex].commentCount + 1);

      yield currentState.copyWith(posts: changedPosts);
    }
  }

  Stream<PostsState> _mapDecrementCommentCountToState(
      DecrementCommentCount event) async* {
    final currentState = state;
    if (currentState is PostsLoaded || currentState is PostsReachedMax) {
      await postRepository.updateCommentCount(event.id, -1);
      final changedPostIndex =
          currentState.posts.indexWhere((element) => element.id == event.id);

      final changedPosts = currentState.posts.toList()
        ..[changedPostIndex] = currentState.posts[changedPostIndex].copyWith(
            commentCount:
                currentState.posts[changedPostIndex].commentCount - 1);

      yield currentState.copyWith(posts: changedPosts);
    }
  }

  Stream<PostsState> _mapPostsRefreshedToState() async* {
    try {
      final newPosts = await postRepository.setupPosts();

      if (newPosts.isEmpty) {
        yield const PostsEmpty();
        return;
      }

      PostsState newState;
      if (newPosts.length < 20) {
        //less than limit in repository
        newState = PostsReachedMax(posts: newPosts);
      } else {
        newState = PostsLoaded(posts: newPosts);
      }

      assert(
          const ListEquality<Post>().equals(
              newPosts.toList()
                ..sort((Post a, Post b) => b.postTime.compareTo(a.postTime)),
              newPosts),
          'States Post List must be properly sorted');

      yield newState;
    } catch (error) {
      print(error.toString());
      yield PostsError(
        failure: Failure(
            'There was a problem refreshing the posts', error.toString()),
      );
    }
  }

  Stream<PostsState> _mapPostsFetchedToState() async* {
    assert(
        const ListEquality<Post>().equals(
            state.posts.toList()
              ..sort((Post a, Post b) => b.postTime.compareTo(a.postTime)),
            state.posts),
        'States Post List must be properly sorted');

    try {
      final posts = await postRepository.fetchNextPage(
          startAfter: state.posts.last.postTime);

      PostsState newState;
      if (posts.length < 20) {
        //less than limit in repository
        newState = PostsReachedMax(posts: state.posts.toList()..addAll(posts));
      } else {
        newState = PostsLoaded(posts: state.posts.toList()..addAll(posts));
      }

      assert(
          const ListEquality<Post>().equals(
              posts.toList()
                ..sort((Post a, Post b) => b.postTime.compareTo(a.postTime)),
              posts),
          'States Post List must be properly sorted');
      assert(state != newState);

      yield newState;
    } catch (error) {
      print(error.toString());
      yield PostsError(
          // posts: state.posts,

          failure:
              Failure('There was an error fetching posts', error.toString()));
    }
  }

  Stream<PostsState> _mapPostSetupToState() async* {
    try {
      final posts = await postRepository.setupPosts();

      if (posts.isEmpty) {
        yield const PostsEmpty();
        return;
      }

      PostsState newState;
      if (posts.length < 20) {
        //less than limit in repository
        newState = PostsReachedMax(posts: posts);
      } else {
        newState = PostsLoaded(posts: posts);
      }

      assert(
          const ListEquality<Post>().equals(
              posts.toList()
                ..sort((Post a, Post b) => b.postTime.compareTo(a.postTime)),
              posts),
          'States Post List must be properly sorted');
      assert(state != newState);

      yield newState;
    } catch (error) {
      print(error.toString());
      yield PostsError(
          failure:
              Failure('There was an error setting up posts', error.toString()));
    }
  }

  /// Adds post to hold post Data
  ///
  /// Can be used when in PostsLoaded, PostsEmpty, or PostsReachedMax
  Stream<PostsState> _mapPostAddedToState(AddPost event) async* {
    // Propagate map to database
    final post =
        await postRepository.addPost(event.author, event.body, event.imageUrl);

    final currentState = state;
    PostsState newState;
    if (currentState is PostsEmpty) {
      newState = PostsReachedMax(posts: [post]);
    } else {
      newState = state.copyWith(posts: state.posts.toList()..insert(0, post));
    }
    // Create new state

    //Ensure newState updated properly
    assert(newState != state,
        'States must be different for updates to properly occur');
    yield newState;
  }

  /// Adds like to post in current state post list and
  /// propagates the like to the database
  ///
  /// Can be used in PostsLoaded, PostsReachedMax state.
  Stream<PostsState> _mapPostLikedToState(LikePost event) async* {
    // Find liked post index in current state
    final int postIndex = state.posts.indexWhere((Post e) => e.id == event.id);

    // Create new modified post which will added to state
    final Post changedPost = state.posts[postIndex].copyWith(
        likedByUser: true, likeCount: state.posts[postIndex].likeCount + 1);

    // Propagate to database
    await postRepository.likePost(event.id);

    // Create new list of posts with modified post added
    final List<Post> newPosts = state.posts.toList()..[postIndex] = changedPost;

    // Create state which will be yielded
    final newState = state.copyWith(
      posts: newPosts,
    );

    // Ensure outputed state is correct
    assert(
        const ListEquality<Post>().equals(
          newState.posts.toList()
            ..sort((Post a, Post b) => b.postTime.compareTo(a.postTime)),
          newState.posts,
        ),
        'Post List must be properly sorted');
    assert(newState != state, 'States must be different to update properly');

    yield newState;
  }

  Stream<PostsState> _mapPostUnlikedToState(UnlikePost event) async* {
    final currentUser = _firebaseAuth.currentUser;

    // Find liked post index in current state
    final int postIndex = state.posts.indexWhere((Post e) => e.id == event.id);

    // Create new modified post which will added to state
    final Post changedPost = state.posts[postIndex].copyWith(
      likedByUser: false,
      unlikedBy: state.posts[postIndex].unlikedBy..add(currentUser.uid),
      likeCount: state.posts[postIndex].likeCount - 1,
    );

    // Propagate to database
    await postRepository.unlikePost(event.id);

    // Create new list of posts with modified post added
    final List<Post> newPosts = state.posts.toList()..[postIndex] = changedPost;

    // Create state which will be yielded
    final newState = state.copyWith(
      posts: newPosts,
    );

    // Ensure outputed state is correct
    assert(
        const ListEquality<Post>().equals(
          newState.posts.toList()
            ..sort((Post a, Post b) => b.postTime.compareTo(a.postTime)),
          newState.posts,
        ),
        'Post List must be properly sorted');
    assert(newState != state, 'States must be different to update properly');

    yield newState;
  }
}
