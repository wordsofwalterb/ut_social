part of 'login_bloc.dart';

@immutable
class LoginState {
  final String error;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isPasswordObscured;

  const LoginState({
    @required this.error,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isPasswordObscured,
  });

  factory LoginState.empty() {
    return const LoginState(
      error: null,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isPasswordObscured: true,
    );
  }

  factory LoginState.loading({bool isPasswordObscured}) {
    return LoginState(
      error: null,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isPasswordObscured: isPasswordObscured,
    );
  }

  factory LoginState.failure({bool isPasswordObscured, String error}) {
    return LoginState(
      error: error,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isPasswordObscured: isPasswordObscured,
    );
  }

  factory LoginState.success({bool isPasswordObscured}) {
    return LoginState(
      error: null,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isPasswordObscured: isPasswordObscured,
    );
  }

  LoginState update({
    bool isPasswordObscured,
    String error,
  }) {
    return copyWith(
      error: error,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isPasswordObscured: isPasswordObscured,
    );
  }

  LoginState copyWith({
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isPasswordObscured,
    String error,
  }) {
    return LoginState(
      error: error ?? this.error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  String toString() {
    return '''LoginState {
      error: $error,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isPasswordObscured: $isPasswordObscured,
    }''';
  }
}
