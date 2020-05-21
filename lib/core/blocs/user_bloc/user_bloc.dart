import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/core/entities/student.dart';

import '../../repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  @override
  UserState get initialState => UserInitial();

  UserBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is InitializeUser) {
      yield* _mapAppStartedToState();
    } else if (event is LogInUser) {
      yield* _mapLoggedInToState();
    } else if (event is LogOutUser) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<UserState> _mapAppStartedToState() async* {
    final bool isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final Student currentUser = await _userRepository.getUser();
      yield UserAuthenticated(currentUser);
    } else {
      yield UserUnauthenticated();
    }
  }

  Stream<UserState> _mapLoggedInToState() async* {
    yield UserAuthenticated(await _userRepository.getUser());
  }

  Stream<UserState> _mapLoggedOutToState() async* {
    yield UserUnauthenticated();
    await _userRepository.signOut();
  }
}
