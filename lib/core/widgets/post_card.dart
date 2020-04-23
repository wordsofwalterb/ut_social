import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:like_button/like_button.dart';
import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ut_social/core/repositories/user_repository.dart';
import 'package:ut_social/feed/comment_repository.dart';
import 'package:ut_social/feed/comment_screen.dart';
import 'package:ut_social/feed/post_repository.dart';

import '../entities/post.dart';
import '../util/helper.dart';
import 'profile_avatar.dart';


class PostCard extends StatelessWidget {
  final Post _post;
  final bool disableComment;
  final bool isLiked;

  const PostCard({Key key, @required Post post, this.disableComment = false})
      : assert(post != null),
        _post = post,
        super(key: key);



  Future<bool> _onLikeButtonTapped(bool isLiked, BuildContext context) async {
    if (isLiked) {
      BlocProvider.of<AuthenticationBloc>(context)
        ..add(AuthDislikePost(widget._post.postId));
      return false;
    } else {
      BlocProvider.of<AuthenticationBloc>(context)
        ..add(AuthLikedPost(widget._post.postId));
      return true;
    }
  }

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
                avatarUrl: widget._post.avatarUrl,
                userId: widget._post.authorId,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  widget._post.authorName,
                  style: Theme.of(context).textTheme.subtitle,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                child: Text(
                  Helper.convertTime(widget._post.postTime),
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
              widget._post.body,
              style: Theme.of(context).textTheme.body1,
            ),
          ),

          ImageWidget(widget._post.imageUrl),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              (!widget.disableComment)
                  ? GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return CommentScreen(widget._post);
                        }),
                      ),
                      child: const Icon(
                        SFSymbols.bubble_left,
                        size: 20,
                      ),
                    )
                  : Container(),
              (!widget.disableComment)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(widget._post.commentCount.toString(),
                          style: Theme.of(context).textTheme.overline),
                    )
                  : Container(),
              (!widget.disableComment)
                  ? Spacer(
                      flex: 1,
                    )
                  : Container(),
              // BlocBuilder<AuthenticationBloc, AuthenticationState>(
              //     builder: (context, state) {
              //   if (state is AuthAuthenticated) {
              LikeButton(),
              LikeButton(
                size: 20,
                //likeCount: likeCount,
                animationDuration: const Duration(milliseconds: 500),
                isLiked: ,
                onTap: (result) {
                  return _onLikeButtonTapped(result, context);
                },
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
              ),
              // } else {
              //   return Container();
              // }
              // }),
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
