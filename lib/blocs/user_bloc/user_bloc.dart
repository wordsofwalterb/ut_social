import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:ut_social/models/student.dart';
import 'package:ut_social/services/user_repository.dart';
import 'package:ut_social/util/globals.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(UserInitial());

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
    if (event is UpdateUserProfile) {
      yield* _mapUpdateUserProfileToState(event);
    }
  }

  Stream<UserState> _mapUpdateUserProfileToState(
      UpdateUserProfile event) async* {
    final currentState = state;
    if (currentState is UserAuthenticated) {
      // String avatarUrl;
      // if (event.avatarFile != null) {
      //   avatarUrl = await StorageService.uploadUserProfileImage(
      //       currentState.currentUser.avatarUrl, event.avatarFile);
      // }

      // String coverPhotoUrl;
      // if (event.avatarFile != null) {
      //   avatarUrl = _userRepository.uploadCoverPhoto(event.coverPhotoFile);
      // }
      final updatedUser = Student(
        id: currentState.currentUser.id,
        fullName:
            _getFullName(firstName: event.firstName, lastName: event.lastName),
        // channels: event.channels ?? currentState.currentUser.channels,
        reportCount: event.reportCount ?? currentState.currentUser.reportCount,
        firstName: event.firstName ?? currentState.currentUser.firstName,
        avatarUrl: event.avatarUrl ?? currentState.currentUser.avatarUrl,
        notificationsEnabled: event.notificationsEnabled ??
            currentState.currentUser.notificationsEnabled,
        coverPhotoUrl:
            event.coverPhotoUrl ?? currentState.currentUser.coverPhotoUrl,
        lastName: event.lastName ?? currentState.currentUser.lastName,
        bio: event.bio ?? currentState.currentUser.bio,
        email: event.email ?? currentState.currentUser.email,
        isTester: event.isTester ?? currentState.currentUser.isTester,
      );

      await _userRepository.updateUser(updatedUser);

      yield UserAuthenticated(updatedUser);
    }
  }

  String _getFullName({String firstName, String lastName}) {
    final currentState = state;
    if (currentState is UserAuthenticated) {
      final fName = firstName ?? currentState.currentUser.firstName;
      final lName = lastName ?? currentState.currentUser.lastName;
      final fullName = '$fName $lName';
      return fullName;
    }
    return null;
  }

  Stream<UserState> _mapAppStartedToState() async* {
    final bool isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final Student currentUser = await _userRepository.getUser();
      // Toggle analytics off if tester
      if (currentUser.isTester) {
        await Global.analytics.setAnalyticsCollectionEnabled(false);
      }
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
