import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:like_button/like_button.dart';
import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ut_social/core/util/router.dart';
import 'package:ut_social/feed/comment_bloc/comment_bloc.dart';
import 'package:ut_social/feed/comment_repository.dart';

import 'package:ut_social/feed/comment_screen.dart';
import 'package:ut_social/feed/post_bloc/post_bloc.dart';

import '../entities/post.dart';
import '../util/helper.dart';
import 'profile_avatar.dart';

class PostCard extends StatefulWidget {
  final Post _post;
  final bool disableComment;
  final bool isLiked;
  final int likeCount;

  const PostCard(
      {Key key,
      @required Post post,
      this.disableComment = false,
      this.isLiked = false,
      this.likeCount = 0})
      : assert(post != null),
        _post = post,
        super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool byCurrentUser = false;

  @override
  Widget build(BuildContext context) {
    final postBloc = BlocProvider.of<PostBloc>(context);
    final authBlocState = BlocProvider.of<AuthenticationBloc>(context).state;

    if (authBlocState is AuthAuthenticated) {
      byCurrentUser = authBlocState.currentUser.id == widget._post.authorId;
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
                  arguments: ProfileArgs(widget._post.authorId,
                      isCurrentUser: byCurrentUser),
                ),
                avatarUrl: widget._post.avatarUrl,
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  widget._post.authorName,
                  style: Theme.of(context).textTheme.subtitle2,
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
            const Spacer(),
            IconButton(
              onPressed: () => {},
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
              widget._post.body,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),

          ImageWidget(widget._post.imageUrl),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              if (!widget.disableComment)
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return BlocProvider<CommentsBloc>(
                        create: (context) => CommentsBloc(
                          widget._post.id,
                          commentRepository: FirebaseCommentsRepository(),
                        ),
                        child: BlocProvider.value(
                            value: postBloc,
                            child: CommentScreen(widget._post)),
                      );
                    }),
                  ),
                  child: const Icon(
                    SFSymbols.bubble_left,
                    size: 20,
                  ),
                )
              else
                Container(),
              if (!widget.disableComment)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(widget._post.commentCount.toString(),
                      style: Theme.of(context).textTheme.overline),
                )
              else
                Container(),
              if (!widget.disableComment)
                const Spacer(
                  flex: 1,
                )
              else
                Container(),
              LikeCounter(widget._post.id),
              const Spacer(
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

class LikeCounter extends StatefulWidget {
  final String id;

  const LikeCounter(this.id);

  @override
  _LikeCounterState createState() => _LikeCounterState();
}

class _LikeCounterState extends State<LikeCounter> {
  bool isLiked = false;
  // AuthenticationState authBlocState;
  String currentUserId;

  @override
  void initState() {
    super.initState();
    // isLiked = BlocProvider.of<PostBloc>(context).isLiked(widget.id);
    //authBlocState = BlocProvider.of<AuthenticationBloc>(context).state;
  }

  Future<bool> _onLikeButtonTapped(BuildContext context) async {
    if (isLiked) {
      BlocProvider.of<PostBloc>(context).add(PostUnlike(widget.id));
      return false;
    } else {
      BlocProvider.of<PostBloc>(context).add(PostLike(widget.id));
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authBlocState = BlocProvider.of<AuthenticationBloc>(context).state;

    if (authBlocState is AuthAuthenticated) {
      currentUserId = authBlocState.currentUser.id;
    }

    return BlocBuilder<PostBloc, PostState>(condition: (previousState, state) {
      if (state is PostLoaded && state.lastPostLiked == widget.id) return true;
      if (state is PostLoaded && state.isRefreshed != null) return true;
      return false;
    }, builder: (context, state) {
      if (state is PostLoaded) {
        final results = state.posts.firstWhere((e) => e.id == widget.id);
        isLiked = results.likedBy.contains(currentUserId);
        return LikeButton(
          size: 20,
          likeCount: state.posts
              .firstWhere((element) => element.id == widget.id)
              .likeCount,
          animationDuration: const Duration(milliseconds: 500),
          isLiked: isLiked,
          onTap: (result) {
            return _onLikeButtonTapped(context);
          },
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
      } else {
        return const Padding(
          padding: EdgeInsets.all(0),
        );
      }
    });
  }
}
