import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../core/entities/comment.dart';
import 'package:ut_social/core/entities/comment.dart';
import 'package:ut_social/core/entities/failure.dart';
import 'package:ut_social/core/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final String _postId;

  CommentsBloc(
    this._postId, {
    this.commentRepository,
  });

  final CommentRepository commentRepository;

  @override
  CommentsState get initialState => CommentsInitial(postId: _postId);

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    final currentState = state;
    if (currentState is CommentsInitial) {
      if (event is SetupComments) {
        yield* _mapCommentSetupToState();
      }
    }
    if (currentState is CommentsError) {
      if (event is RefreshComments) {
        yield* _mapCommentsRefreshedToState();
      }
    }
    if (currentState is CommentsEmpty) {
      if (event is RefreshComments) {
        yield* _mapCommentsRefreshedToState();
      } else if (event is AddComment) {
        yield* _mapCommentAddedToState(event.map);
      }
    }
    if (currentState is CommentsReachedMax) {
      if (event is AddComment) {
        yield* _mapCommentAddedToState(event.map);
      } else if (event is LikeComment) {
        yield* _mapCommentLikedToState(event.id);
      } else if (event is UnlikeComment) {
        yield* _mapCommentUnlikedToState(event.id);
      } else if (event is RefreshComments) {
        yield* _mapCommentsRefreshedToState();
      } else if (event is DeleteComment) {
        yield* _mapDeleteCommentToState(event);
      }
    }
    if (currentState is CommentsLoaded) {
      if (event is AddComment) {
        yield* _mapCommentAddedToState(event.map);
      } else if (event is LikeComment) {
        yield* _mapCommentLikedToState(event.id);
      } else if (event is UnlikeComment) {
        yield* _mapCommentUnlikedToState(event.id);
      } else if (event is RefreshComments) {
        yield* _mapCommentsRefreshedToState();
      } else if (event is FetchComments) {
        yield* _mapCommentsFetchedToState();
      } else if (event is DeleteComment) {
        yield* _mapDeleteCommentToState(event);
      }
    }
  }

  Stream<CommentsState> _mapDeleteCommentToState(DeleteComment event) async* {
    final currentState = state;
    if (currentState is CommentsLoaded || currentState is CommentsReachedMax) {
      final newComments = currentState.comments.toList();
      newComments.remove(event.comment);
      yield currentState.copyWith(comments: newComments);
    }
    await commentRepository.deleteComment(event.comment.id);
  }

  Stream<CommentsState> _mapCommentsRefreshedToState() async* {
    try {
      final newComments =
          await commentRepository.setupCommentsFor(state.postId);

      if (newComments.isEmpty) {
        yield CommentsEmpty(
          postId: state.postId,
        );
        return;
      }

      CommentsState newState;
      if (newComments.length < 20) {
        //less than limit in repository
        newState =
            CommentsReachedMax(postId: state.postId, comments: newComments);
      } else {
        newState = CommentsLoaded(postId: state.postId, comments: newComments);
      }

      assert(
          const ListEquality<Comment>().equals(
              newComments.toList()
                ..sort((Comment a, Comment b) =>
                    a.timestamp.compareTo(b.timestamp)),
              newComments),
          'States Comment List must be properly sorted');

      yield newState;
    } catch (error) {
      yield CommentsError(
        failure: Failure(
            'There was a problem refreshing the comments', error.toString()),
        postId: state.postId,
      );
    }
  }

  Stream<CommentsState> _mapCommentsFetchedToState() async* {
    assert(
        const ListEquality<Comment>().equals(
            state.comments.toList()
              ..sort(
                  (Comment a, Comment b) => a.timestamp.compareTo(b.timestamp)),
            state.comments),
        'States Comment List must be properly sorted');

    try {
      final comments = await commentRepository.fetchNextPage(
          startAfter: state.comments.last.timestamp, postId: _postId);

      CommentsState newState;
      if (comments.length < 20) {
        //less than limit in repository
        newState = CommentsReachedMax(
            postId: state.postId,
            comments: state.comments.toList()..addAll(comments));
      } else {
        newState = CommentsLoaded(
            postId: state.postId,
            comments: state.comments.toList()..addAll(comments));
      }

      assert(
          const ListEquality<Comment>().equals(
              comments.toList()
                ..sort((Comment a, Comment b) =>
                    a.timestamp.compareTo(b.timestamp)),
              comments),
          'States Comment List must be properly sorted');
      assert(state != newState);

      yield newState;
    } catch (error) {
      yield CommentsError(
          postId: state.postId,
          // comments: state.comments,
          failure: Failure(
              'There was an error fetching comments', error.toString()));
    }
  }

  Stream<CommentsState> _mapCommentSetupToState() async* {
    try {
      final comments = await commentRepository.setupCommentsFor(state.postId);

      if (comments.isEmpty) {
        yield CommentsEmpty(
          postId: state.postId,
        );
        return;
      }

      CommentsState newState;
      if (comments.length < 20) {
        //less than limit in repository
        newState = CommentsReachedMax(postId: state.postId, comments: comments);
      } else {
        newState = CommentsLoaded(postId: state.postId, comments: comments);
      }

      assert(
          const ListEquality<Comment>().equals(
              comments.toList()
                ..sort((Comment a, Comment b) =>
                    a.timestamp.compareTo(b.timestamp)),
              comments),
          'States Comment List must be properly sorted');
      assert(state != newState);

      yield newState;
    } catch (error) {
      yield CommentsError(
          postId: state.postId,
          failure: Failure(
              'There was an error setting up comments', error.toString()));
    }
  }

  /// Adds comment to hold comment Data
  ///
  /// Can be used when in CommentsLoaded, CommentsEmpty, or CommentsReachedMax
  Stream<CommentsState> _mapCommentAddedToState(
      Map<String, dynamic> map) async* {
    assert(map != null);

    // Propagate map to database
    final comment = await commentRepository.addComment(map);

    final currentState = state;
    CommentsState newState;
    if (currentState is CommentsEmpty) {
      newState = CommentsReachedMax(postId: state.postId, comments: [comment]);
    } else {
      newState =
          state.copyWith(comments: state.comments.toList()..add(comment));
    }
    // Create new state

    //Ensure newState updated properly
    assert(newState != state,
        'States must be different for updates to properly occur');
    yield newState;
  }

  /// Adds like to comment in current state comment list and
  /// propagates the like to the database
  ///
  /// Can be used in CommentsLoaded, CommentsReachedMax state.
  Stream<CommentsState> _mapCommentLikedToState(String id) async* {
    assert(id != null);

    // Find liked comment index in current state
    final int commentIndex =
        state.comments.indexWhere((Comment e) => e.id == id);

    // Create new modified comment which will added to state
    final Comment changedComment = state.comments[commentIndex].copyWith(
        isLikedByUser: true,
        likeCount: state.comments[commentIndex].likeCount + 1);

    // Propagate to database
    await commentRepository.likeComment(id);

    // Create new list of comments with modified comment added
    final List<Comment> newComments = state.comments.toList()
      ..[commentIndex] = changedComment;

    // Create state which will be yielded
    final newState = state.copyWith(
      comments: newComments,
    );

    // Ensure outputed state is correct
    assert(
        const ListEquality<Comment>().equals(
          newState.comments.toList()
            ..sort(
                (Comment a, Comment b) => a.timestamp.compareTo(b.timestamp)),
          newState.comments,
        ),
        'Comment List must be properly sorted');
    assert(newState != state, 'States must be different to update properly');

    yield newState;
  }

  Stream<CommentsState> _mapCommentUnlikedToState(String id) async* {
    assert(id != null);

    // Find liked comment index in current state
    final int commentIndex =
        state.comments.indexWhere((Comment e) => e.id == id);

    // Create new modified comment which will added to state
    final Comment changedComment = state.comments[commentIndex].copyWith(
        isLikedByUser: false,
        likeCount: state.comments[commentIndex].likeCount - 1);

    // Propagate to database
    await commentRepository.unlikeComment(id);

    // Create new list of comments with modified comment added
    final List<Comment> newComments = state.comments.toList()
      ..[commentIndex] = changedComment;

    // Create state which will be yielded
    final newState = state.copyWith(
      comments: newComments,
    );

    // Ensure outputed state is correct
    assert(
        const ListEquality<Comment>().equals(
          newState.comments.toList()
            ..sort(
                (Comment a, Comment b) => a.timestamp.compareTo(b.timestamp)),
          newState.comments,
        ),
        'Comment List must be properly sorted');
    assert(newState != state, 'States must be different to update properly');

    yield newState;
  }
}
