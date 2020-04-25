import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ut_social/core/entities/comment.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/feed/comment_repository.dart';
import 'package:ut_social/feed/post_bloc/post_bloc.dart';
import 'package:collection/collection.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  AuthenticationBloc authBloc;
  StreamSubscription authBlocSubscription;

  CommentRepository commentRepository;
  Student _currentUser;

  CommentBloc({this.commentRepository, this.authBloc}) {
    authBlocSubscription = authBloc.listen((authState) {
      if (authState is AuthAuthenticated) {
        _currentUser = authState.currentUser;
      }
      assert(_currentUser != null);
    });
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }

  @override
  CommentState get initialState => CommentInitial();

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    final currentState = state;

    if (currentState is CommentLoaded) {
      if (event is CommentAdded) {
        yield* _mapCommentAddedToState(event.body, currentState);
      } else if (event is CommentLiked) {
        yield* _mapCommentLikedToState();
      } else if (event is CommentUnliked) {
        yield* _mapCommentUnlikedToState();
      }
    } else {
      if (currentState is CommentInitial) {
        if (event is CommentSetup) {
          yield* _mapCommentSetupToState(event.postId);
        }
      }
    }
  }

  Stream<CommentState> _mapCommentSetupToState(String postId) async* {
    assert(postId != null);

    final comments =
        await commentRepository.setupFeed(postId); // TODO: Add Try Catch

    if (comments != null) {
      assert(ListEquality().equals(
          comments
            ..toList()
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp)),
          comments)); // Ensures list is Properly sorted

      final newState = CommentLoaded(postId: postId, comments: comments);
      assert(state != newState);
      yield newState;
    }
    print("No comments loaded from Repository");
  }

  Stream<CommentState> _mapCommentAddedToState(
      String body, CommentLoaded currentState) async* {
    assert(body != null);

    final comment = await commentRepository.addComment(
        currentState.postId, _currentUser, body); // TODO: Add Try Catch

    final newState = CommentLoaded(
        postId: currentState.postId,
        comments: currentState.comments
          .toList()
          ..insert(0, comment));

    assert(newState != currentState);

    yield newState;
  }

  Stream<CommentState> _mapCommentLikedToState() {}

  Stream<CommentState> _mapCommentUnlikedToState() {}
}
