import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/student.dart';

import '../../repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthenticationState> {
  final UserRepository _userRepository;

  @override
  AuthenticationState get initialState => AuthInitial();

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthAppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is AuthLoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is AuthLoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is AuthLikedPost) {
      yield* _mapLikePostToState(event.postId);
    } else if (event is AuthDislikePost) {
      yield* _mapDislikePostToState(event.postId);
    } else if (event is AuthDislikedComment) {
      yield* _mapDislikedCommentToState(event.commentId);
    } else if (event is AuthLikedComment) {
      yield* _mapLikedCommentToState(event.commentId);
    }
  }

  Stream<AuthenticationState> _mapDislikedCommentToState(
      String commentId) async* {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      try {
        await _userRepository.dislikeComment(
            commentId, currentState.currentUser.id);
        yield AuthAuthenticated(
          currentState.currentUser.copyWith(
            likedPosts: currentState.currentUser.likedComments
              ..remove([commentId]),
          ),
        );
      } catch (error) {
        print(error);
      }
    }
  }

  Stream<AuthenticationState> _mapLikedCommentToState(String commentId) async* {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      try {
        await _userRepository.likeComment(
            commentId, currentState.currentUser.id);
        yield AuthAuthenticated(
          currentState.currentUser.copyWith(
            likedPosts: currentState.currentUser.likedComments
              ..addAll([commentId]),
          ),
        );
      } catch (error) {
        print(error);
      }
    }
  }

  Stream<AuthenticationState> _mapLikePostToState(String postId) async* {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      try {
        await _userRepository.likePost(postId, currentState.currentUser.id);
        yield AuthAuthenticated(
          currentState.currentUser.copyWith(
            likedPosts: currentState.currentUser.likedPosts..addAll([postId]),
          ),
        );
      } catch (error) {
        print(error);
      }
    }
  }

  Stream<AuthenticationState> _mapDislikePostToState(String postId) async* {
    final currentState = state;
    if (currentState is AuthAuthenticated) {
      try {
        await _userRepository.dislikePost(postId, currentState.currentUser.id);
        yield AuthAuthenticated(
          currentState.currentUser.copyWith(
            likedPosts: currentState.currentUser.likedPosts..remove(postId),
          ),
        );
      } catch (error) {
        print(error);
      }
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final student = await _userRepository.getUser();
      yield AuthAuthenticated(student);
    } else {
      yield AuthUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield AuthAuthenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthUnauthenticated();
    _userRepository.signOut();
  }
}
