part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => const <Object>[];
}

class InitializeUser extends UserEvent {}

class LogInUser extends UserEvent {}

class LogOutUser extends UserEvent {}
