// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:like_button/like_button.dart';
// import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';

// class LikePost extends StatefulWidget {
//   final int likeCount;
//   final String postId;
//   final bool isInitiallyLiked;

//   LikePost({Key key, this.likeCount, this.postId, this.isInitiallyLiked}) : super(key: key);

//   @override
//   _LikePostState createState() => _LikePostState();
// }

// class _LikePostState extends State<LikePost> {
//   int likes;
//   bool isLiked;

//   @override
//   void initState() {
//     isLiked = widget.isInitiallyLiked;
//     likes = widget.likeCount;
//     super.initState();
//   }

//   Future<bool> _onLikeButtonTapped(bool liked, BuildContext context) async {
//     if (liked) {
//       BlocProvider.of<AuthenticationBloc>(context)
//         ..add(AuthDislikePost(widget.postId));
//       return false;
//     } else {
//       BlocProvider.of<AuthenticationBloc>(context)
//         ..add(AuthLikedPost(widget.postId));
//       return true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//                   builder: (context, state) {
//                 if (state is AuthAuthenticated) {
//                   return LikeButton(
//                     size: 20,
//                     likeCount: likes,
//                     animationDuration: const Duration(milliseconds: 500),
//                     isLiked:
//                         state.currentUser.likedPosts.contains(widget.postId),
//                     onTap: (result) {
//                       return _onLikeButtonTapped(result, context);
//                     },
//                     likeCountAnimationDuration:
//                         const Duration(milliseconds: 200),
//                     countBuilder: (int count, bool isLiked, String text) {
//                       Widget result;
//                       if (count == 0) {
//                         result = Text(
//                           "",
//                           style: TextStyle(color: Colors.grey),
//                         );
//                       } else
//                         result = Text(
//                           text,
//                           style: TextStyle(color: Colors.grey),
//                         );
//                       return result;
//                     },
//                   );,
//     );
//   }
// }
