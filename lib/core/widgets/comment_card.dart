import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:like_button/like_button.dart';
import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';

import '../entities/comment.dart';
import '../util/helper.dart';
import 'profile_avatar.dart';

class CommentCard extends StatelessWidget {
  final Comment _comment;

  const CommentCard({Key key, @required Comment comment})
      : assert(comment != null),
        _comment = comment,
        super(key: key);

  // Future<bool> _onLikeButtonTapped(bool isLiked, BuildContext context) async {
  //   if (isLiked) {
  //     BlocProvider.of<AuthenticationBloc>(context)
  //       ..add(AuthDislikedComment(_comment.commentId));
  //   } else {
  //     BlocProvider.of<AuthenticationBloc>(context)
  //       ..add(AuthLikedComment(_comment.commentId));
  //   }
  //   return !isLiked;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: ProfileAvatar(
                avatarUrl: _comment.authorAvatar,
                userId: _comment.authorId,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  _comment.authorName,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: Text(
                  Helper.convertTime(_comment.timestamp),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ]), // End User Info Block
            Spacer(),
            IconButton(
              onPressed: () => {},
              icon: const Icon(
                SFSymbols.chevron_down,
                size: 20,
              ),
              color: Color(0xff9b9b9b),
            ),
          ]), // End Top Section

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Text(
              _comment.body,
              style: Theme.of(context).textTheme.body1,
            ),
          ),

          // ImageWidget(_comment.imageUrl),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return LikeButton(
                    size: 20,
                  //  likeCount: _comment?.likeCount,
                    animationDuration: const Duration(milliseconds: 500),
                  //  isLiked: state.currentUser.likedComments.contains(_comment.commentId),
                   // onTap:  (result) => _onLikeButtonTapped(result, context),
                    likeCountAnimationDuration: const Duration(milliseconds: 200),
                    countBuilder: (int count, bool isLiked, String text) {
                      Widget result;
                      if (count == 0) {
                        result = Text(
                          "",
                          style: TextStyle(color: Colors.grey),
                        );
                      } else
                        result = Text(
                          text,
                          style: TextStyle(color: Colors.grey),
                        );
                      return result;
                    },
                  );
                }else {
                return Container();
                }
              } ),
              Spacer(
                flex: 9,
              ),
              const Icon(
                SFSymbols.square_arrow_up,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 5, 6, 0),
                child:
                    Text('Share', style: Theme.of(context).textTheme.caption),
              ),
            ]),
          ), // Bottom Section
        ]), // End Content
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  ImageWidget(this.imageUrl, {Key key}) : super(key: key);

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
