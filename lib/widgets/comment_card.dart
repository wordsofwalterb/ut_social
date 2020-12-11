import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:like_button/like_button.dart';
import 'package:ut_social/blocs/comment_bloc/comment_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';
import 'package:ut_social/models/comment.dart';
import 'package:ut_social/util/router.dart';

import '../util/globals.dart';
import '../util/helper.dart';
import 'profile_avatar.dart';

typedef CommentChevronCallback = void Function(
    bool byCurrentUser, Comment comment);

class CommentCard extends StatefulWidget {
  final Comment _comment;
  final CommentChevronCallback chevronCallback;

  const CommentCard({
    Key key,
    @required Comment comment,
    this.chevronCallback,
  })  : assert(comment != null),
        _comment = comment,
        super(key: key);

  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool byCurrentUser = false;

  Future<bool> _onLikeButtonTapped(bool isLiked, BuildContext context) async {
    if (isLiked) {
      BlocProvider.of<CommentsBloc>(context)
          .add(UnlikeComment(widget._comment.id));
    } else {
      BlocProvider.of<CommentsBloc>(context)
          .add(LikeComment(widget._comment.id));

      final userBlocState = BlocProvider.of<UserBloc>(context).state;
      if (userBlocState is UserAuthenticated) {
        if (!byCurrentUser &&
            !widget._comment.unlikedBy.contains(userBlocState.currentUser.id)) {
          Global.studentsRef
              .document(widget._comment.authorId)
              .collection('notifications')
              .add({
            'body': '${userBlocState.currentUser.fullName} liked your comment.',
            'imageUrl': userBlocState.currentUser.avatarUrl,
            'timestamp': DateTime.now(),
            'originId': userBlocState.currentUser.id,
            'title': 'New Like',
          });
        }
      }
    }
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final userBlocState = BlocProvider.of<UserBloc>(context).state;

    if (userBlocState is UserAuthenticated) {
      byCurrentUser = userBlocState.currentUser.id == widget._comment.authorId;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: ProfileAvatar(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.profile,
                  arguments: ProfileArgs(widget._comment.authorId,
                      isCurrentUser: byCurrentUser),
                ),
                avatarUrl: widget._comment.authorAvatar,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  widget._comment.authorName,
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: Text(
                  Helper.convertTime(widget._comment.timestamp),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ]), // End User Info Block
            const Spacer(),
            IconButton(
              onPressed: () =>
                  widget.chevronCallback(byCurrentUser, widget._comment),
              icon: const Icon(
                SFSymbols.chevron_down,
                size: 20,
              ),
              color: const Color(0xff9b9b9b),
            ),
          ]), // End Top Section

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Text(
              widget._comment.body,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),

          // ImageWidget(_comment.imageUrl),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              BlocBuilder<CommentsBloc, CommentsState>(
                  builder: (context, state) {
                return LikeButton(
                  size: 20,
                  likeCount: widget._comment.likeCount,
                  animationDuration: const Duration(milliseconds: 500),
                  isLiked: widget._comment.likedByUser,
                  onTap: (result) => _onLikeButtonTapped(result, context),
                  likeCountAnimationDuration: const Duration(milliseconds: 200),
                  countBuilder: (int count, bool isLiked, String text) {
                    Widget result;
                    if (count == 0) {
                      result = const Text(
                        '',
                        style: TextStyle(color: Colors.grey),
                      );
                    } else {
                      result = Text(
                        text,
                        style: const TextStyle(color: Colors.grey),
                      );
                    }
                    return result;
                  },
                );
              }),
              const Spacer(
                flex: 9,
              ),
              // const Icon(
              //   SFSymbols.square_arrow_up,
              //   size: 20,
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(6, 5, 6, 0),
              //   child:
              //       Text('Share', style: Theme.of(context).textTheme.caption),
              // ),
            ]),
          ), // Bottom Section
        ]), // End Content
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  const ImageWidget(this.imageUrl, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl != null && imageUrl != '')
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Container(
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : Container();
  }
}
