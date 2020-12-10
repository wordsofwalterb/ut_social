import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:like_button/like_button.dart';
import 'package:ut_social/blocs/post_bloc/post_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';

import 'package:ut_social/models/post.dart';

import 'package:ut_social/util/globals.dart';
import 'package:ut_social/util/router.dart';

import '../util/helper.dart';
import 'profile_avatar.dart';

typedef PostChevronCallback = void Function(bool byCurrentUser, Post post);

class PostCard extends StatefulWidget {
  final Post _post;
  final bool disableComment;
  final bool isLiked;
  final int likeCount;
  final PostChevronCallback onChevronTap;

  const PostCard(
      {Key key,
      @required Post post,
      this.disableComment = false,
      this.isLiked = false,
      this.onChevronTap,
      this.likeCount = 0})
      : assert(post != null),
        _post = post,
        super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool byCurrentUser = false;

  Future<bool> _onLikeButtonTapped(bool isLiked, BuildContext context) async {
    if (isLiked) {
      BlocProvider.of<PostsBloc>(context).add(UnlikePost(widget._post.id));
    } else {
      BlocProvider.of<PostsBloc>(context).add(LikePost(widget._post.id));

      final userBlocState = BlocProvider.of<UserBloc>(context).state;
      if (userBlocState is UserAuthenticated) {
        if (!byCurrentUser &&
            !widget._post.unlikedBy.contains(userBlocState.currentUser.id)) {
          Global.studentsRef
              .doc(widget._post.authorId)
              .collection('notifications')
              .add({
            'body': '${userBlocState.currentUser.fullName} liked your post.',
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
    final postBloc = BlocProvider.of<PostsBloc>(context);
    final userBlocState = BlocProvider.of<UserBloc>(context).state;

    if (userBlocState is UserAuthenticated) {
      byCurrentUser = userBlocState.currentUser.id == widget._post.authorId;
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
              onPressed: () => widget.onChevronTap(byCurrentUser, widget._post),
              icon: const Icon(
                SFSymbols.chevron_down,
                size: 20,
              ),
              color: const Color(0xff9b9b9b),
            ),
          ]), // End Top Section

          if (widget._post.body != '')
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: SelectableText(
                widget._post.body,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          const SizedBox(
            height: 6,
          ),

          ImageWidget(widget._post.imageUrl),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              GestureDetector(
                onTap: (widget.disableComment)
                    ? () => {}
                    : () => Navigator.of(context).pushNamed(
                          Routes.postComments,
                          arguments: PostCommentsArgs(postBloc, widget._post),
                        ),
                child: const Icon(
                  SFSymbols.bubble_left,
                  size: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(widget._post.commentCount.toString(),
                    style: Theme.of(context).textTheme.overline),
              ),
              const Spacer(
                flex: 1,
              ),
              BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  return LikeButton(
                    size: 20,
                    likeCount: widget._post.likeCount,
                    animationDuration: const Duration(milliseconds: 500),
                    isLiked: widget._post.likedByUser ?? false,
                    onTap: (result) => _onLikeButtonTapped(result, context),
                    likeCountAnimationDuration:
                        const Duration(milliseconds: 200),
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
                },
              ),
              const Spacer(
                flex: 12,
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

// class LikeCounter extends StatefulWidget {
//   final String id;
//   final bool isLiked;

//   const LikeCounter(this.id, this.isLiked);

//   @override
//   _LikeCounterState createState() => _LikeCounterState();
// }

// class _LikeCounterState extends State<LikeCounter> {
//   bool isLiked = false;
//   // AuthenticationState authBlocState;
//   String currentUserId;

//   @override
//   void initState() {
//     super.initState();
//     // isLiked = BlocProvider.of<PostBloc>(context).isLiked(widget.id);
//     //authBlocState = BlocProvider.of<AuthenticationBloc>(context).state;
//   }

//   Future<bool> _onLikeButtonTapped(BuildContext context) async {
//     if (isLiked) {
//       BlocProvider.of<PostsBloc>(context).add(UnlikePost(widget.id));
//       return false;
//     } else {
//       BlocProvider.of<PostsBloc>(context).add(LikePost(widget.id));
//       return true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userBlocState = BlocProvider.of<UserBloc>(context).state;

//     if (userBlocState is UserAuthenticated) {
//       currentUserId = userBlocState.currentUser.id;
//     }

//     return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
//       if (state is PostsLoaded || state is PostsReachedMax) {
//         // final results = state.posts.firstWhere((e) => e.id == widget.id);
//         // isLiked = results.likedBy.contains(currentUserId);
//         return LikeButton(
//           size: 20,
//           likeCount: state.posts
//               .firstWhere((element) => element.id == widget.id)
//               .likeCount,
//           animationDuration: const Duration(milliseconds: 500),
//           isLiked: widget._comment.isLikedByUser,
//           onTap: (result) => _onLikeButtonTapped(result, context),
//           likeCountAnimationDuration: const Duration(milliseconds: 200),
//           countBuilder: (int count, bool isLiked, String text) {
//             Widget result;
//             if (count == 0) {
//               result = const Text(
//                 '',
//                 style: TextStyle(color: Colors.grey),
//               );
//             } else {
//               result = Text(
//                 text,
//                 style: const TextStyle(color: Colors.grey),
//               );
//             }
//             return result;
//           },
//         );
//       } else {
//         return const Padding(
//           padding: EdgeInsets.all(0),
//         );
//       }
//     });
//   }
// }
