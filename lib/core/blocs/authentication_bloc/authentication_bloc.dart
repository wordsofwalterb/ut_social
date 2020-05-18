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
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final bool isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final Student currentUser = await _userRepository.getUser();
      yield AuthAuthenticated(currentUser);
    } else {
      yield AuthUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield AuthAuthenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthUnauthenticated();
    await _userRepository.signOut();
  }
}
