import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/feed/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc({@required PostRepository postRepository})
      : assert(postRepository != null),
        _postRepository = postRepository;

  @override
  get initialState => PostInitial();

  @override
  Stream<PostState> transformEvents(
    Stream<PostEvent> events,
    Stream<PostState> Function(PostEvent event) next,
  ) {
    final debounceStream = events.debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(debounceStream, next);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await _fetchPosts(0, 20);
          yield PostsLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostsLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostsLoaded(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostsError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostsLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    _postRepository.fetchAllPosts();
  }
}
