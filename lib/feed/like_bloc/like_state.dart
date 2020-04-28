part of 'like_bloc.dart';

class LikeState extends Equatable {
  final String id;
  final int likeCount;
  final bool isLikedByUser;

  const LikeState({@required this.id, this.likeCount, this.isLikedByUser});

  @override
  List<Object> get props => [id, likeCount, isLikedByUser];
}
