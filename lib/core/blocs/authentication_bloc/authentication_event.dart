part of 'authentication_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthAppStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {}

class AuthLoggedOut extends AuthEvent {}

class AuthLikedPost extends AuthEvent {
  final String postId;

  const AuthLikedPost(this.postId);

  @override
  List<Object> get props => [postId];
}

class AuthDislikePost extends AuthEvent {
  final String postId;

  const AuthDislikePost(this.postId);

  @override
  List<Object> get props => [postId];
}

class AuthLikedComment extends AuthEvent {
  final String commentId;

  const AuthLikedComment(this.commentId);

  @override
  List<Object> get props => [commentId];
}

class AuthDislikedComment extends AuthEvent {
  final String commentId;

  const AuthDislikedComment(this.commentId);

  @override
  List<Object> get props => [commentId];
}
