part of 'like_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => const [];
}

class LikeObject extends LikeEvent {}

class UnlikeObject extends LikeEvent {}
