import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/repositories/user_repository.dart';
import '../../core/util/validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({
    @required UserRepository userRepository,
  })  : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    } else if (event is ToggledObscurePassword) {
      yield* _mapToggledObscurePasswordToState();
    }
  }

  Stream<LoginState> _mapToggledObscurePasswordToState() async* {
    yield state.update(
      isPasswordObscured: !state.isPasswordObscured,
    );
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading(state.isPasswordObscured);
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success(state.isPasswordObscured);
    } catch (error) {
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Email address not found";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Password is incorrect";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Email and Password signup is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      yield LoginState.failure(state.isPasswordObscured, errorMessage);
    }
  }
}
