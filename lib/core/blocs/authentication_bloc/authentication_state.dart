part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthenticationState {}

class AuthAuthenticated extends AuthenticationState {
  final Student currentUser;

  const AuthAuthenticated(this.currentUser);

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Authenticated { currentUser: $currentUser }';
}

class AuthUnauthenticated extends AuthenticationState {}
