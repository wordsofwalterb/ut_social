part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => const [];
}

class UserInitial extends UserState {}

class UserAuthenticated extends UserState {
  final Student currentUser;

  const UserAuthenticated(this.currentUser);

  @override
  List<Object> get props => [currentUser];

  @override
  String toString() => 'Authenticated { currentUser: $currentUser }';
}

class UserUnauthenticated extends UserState {}
