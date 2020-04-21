import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ut_social/core/util/exceptions.dart';

import '../../core/repositories/user_repository.dart';
import '../../core/util/validators.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.initial();

  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! RegisterEmailChanged &&
          event is! RegisterPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is RegisterEmailChanged ||
          event is RegisterPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapFormSubmittedToState(
          event.email, event.password, event.firstName, event.lastName);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  // TODO: Currently errors are handled in UI using OR statements, this should be shifted to polymophism
  
  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async* {
    String errorMessage;
    yield RegisterState.loading(state.isPasswordObscured);
    try {
      if (!Validators.isValidFirstName(firstName))
        throw ValidationException('ERROR_FIRST_NAME');
      if (!Validators.isValidLastName(lastName))
        throw ValidationException('ERROR_LAST_NAME');
      if (!Validators.isValidEmail(email))
        throw ValidationException('ERROR_EMAIL');
      if (!Validators.isValidUTEmail(email))
        throw ValidationException('ERROR_EMAIL_UT');
      await _userRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      yield RegisterState.success(state.isPasswordObscured);
    } on ValidationException catch (error) {
      switch (error.code) {
        case 'ERROR_FIRST_NAME':
          errorMessage = 'First name needs to be provided';
          break;
        case 'ERROR_LAST_NAME':
          errorMessage = 'Last name needs to be provided';
          break;
        case 'ERROR_EMAIL':
          errorMessage = 'Email format is incorrect';
          break;
        case 'ERROR_EMAIL_UT':
          errorMessage = 'UTexas email is required';
          break;
      }
      yield RegisterState.failure(state.isPasswordObscured, errorMessage);
    } catch (error) {
      switch (error.code) {
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Password is too weak";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Invalid email format";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "User with this email already exists.";
          break;
        default:
          errorMessage = "An undefined error happened.";
      }
      yield RegisterState.failure(state.isPasswordObscured, errorMessage);
    }
  }
}
