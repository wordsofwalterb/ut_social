import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/blocs/comment_bloc/comment_bloc.dart';
import 'package:ut_social/blocs/post_bloc/post_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';

import 'package:ut_social/models/comment.dart';

import 'package:ut_social/util/globals.dart';
import 'package:ut_social/widgets/bottom_loader.dart';

import '../models/post.dart';
import '../widgets/comment_card.dart';
import '../widgets/post_card.dart';

class CommentScreen extends StatefulWidget {
  final Post _post;

  const CommentScreen(Post post, {Key key})
      : assert(post != null),
        _post = post,
        super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final _feedController = ScrollController();
  final _scrollThreshold = 200.0;
  bool _isCommenting = false;
  PostsBloc _postBloc;
  CommentsBloc _commentsBloc;

  @override
  void initState() {
    _commentsBloc = BlocProvider.of(context);
    _commentsBloc.add(const SetupComments());
    _feedController.addListener(_onScroll);
    _postBloc = BlocProvider.of(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
    _feedController.dispose();
    _commentsBloc.close();
  }

  void _onScroll() {
    final maxScroll = _feedController.position.maxScrollExtent;
    final currentScroll = _feedController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _commentsBloc.add(FetchComments());
    }
  }

  void _showPostDialog(bool byCurrentUser, Post post) {
    return Platform.isIOS
        ? _iosPostBottomSheet(byCurrentUser, post)
        : _androidPostDialog(byCurrentUser, post);
  }

  void _iosPostBottomSheet(bool byCurrentUser, Post post) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Options'),
          actions: <Widget>[
            if (byCurrentUser) ...{
              CupertinoActionSheetAction(
                onPressed: () => _deletePost(context, post),
                child: const Text('Delete Post'),
              ),
            } else ...{
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Report Post'),
              ),
            }
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }

  void _androidPostDialog(bool byCurrentUser, Post post) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Options'),
          children: <Widget>[
            if (byCurrentUser) ...{
              SimpleDialogOption(
                onPressed: () => _deletePost(context, post),
                child: const Text('Delete Post'),
              ),
            } else ...{
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: const Text('Report Post'),
              ),
            },
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCommentDialog(bool byCurrentUser, Comment comment) {
    return Platform.isIOS
        ? _iosCommentBottomSheet(byCurrentUser, comment)
        : _androidCommentDialog(byCurrentUser, comment);
  }

  void _iosCommentBottomSheet(bool byCurrentUser, Comment comment) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Options'),
          actions: <Widget>[
            if (byCurrentUser) ...{
              CupertinoActionSheetAction(
                onPressed: () => _deleteComment(context, comment),
                child: const Text('Delete Comment'),
              ),
            } else ...{
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: const Text('Report Comment'),
              ),
            }
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }

  void _androidCommentDialog(bool byCurrentUser, Comment comment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Options'),
          children: <Widget>[
            if (byCurrentUser) ...{
              SimpleDialogOption(
                onPressed: () => _deleteComment(context, comment),
                child: const Text('Delete Comment'),
              ),
            } else ...{
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: const Text('Report Comment'),
              ),
            },
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteComment(BuildContext context, Comment comment) async {
    Navigator.pop(context);
    _postBloc.add(DecrementCommentCount(widget._post.id));
    _commentsBloc.add(DeleteComment(comment));
  }

  Future<void> _deletePost(BuildContext context, Post post) async {
    Navigator.pop(context);
    _postBloc.add(DeletePost(post));
    Navigator.pop(context);
  }

  void _addComment() {
    final userBlocState = BlocProvider.of<UserBloc>(context).state;
    if (userBlocState is UserAuthenticated) {
      _commentsBloc.add(
        AddComment(
          {
            'postId': widget._post.id,
            'body': _commentController.text,
            'authorName': userBlocState.currentUser.fullName,
            'authorId': userBlocState.currentUser.id,
            'authorAvatar': userBlocState.currentUser.avatarUrl,
          },
        ),
      );
      _postBloc.add(IncrementCommentCount(widget._post.id));
      // Add notification
      if (userBlocState.currentUser.id != widget._post.authorId) {
        Global.studentsRef
            .document(widget._post.authorId)
            .collection('notifications')
            .add({
          'body':
              '${userBlocState.currentUser.fullName} commented on your post.',
          'imageUrl':
              widget._post.imageUrl ?? userBlocState.currentUser.avatarUrl,
          'timestamp': DateTime.now(),
          'originId': userBlocState.currentUser.id,
          'title': 'New Comment',
        });
      }

      FocusScope.of(context).unfocus();
    }
  }

  Future<void> _refreshFeed() async {
    _commentsBloc.add(RefreshComments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Container(
            width: 75,
            child:
                Image.asset('assets/images/appbar.png', fit: BoxFit.scaleDown)),
        actions: const <Widget>[],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshFeed,
              color: Theme.of(context).primaryColor,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _feedController,
                slivers: <Widget>[
                  _postSliver(),
                  _divider(),
                  _commentsSliver(),
                ],
              ),
            ),
          ),
          _buildCommentComposer(),
        ]),
      ),
    );
  }

  // TODO: This does a search of every post on every update,
  // this is very inneficient, improve later.
  Widget _postSliver() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: BlocBuilder<PostsBloc, PostsState>(
            cubit: _postBloc,
            builder: (context, postState) {
              return PostCard(
                post: postState.posts.singleWhere(
                    (post) => post.id == widget._post.id,
                    orElse: () => widget._post),
                disableComment: true,
                onChevronTap: _showPostDialog,
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _divider() {
    return SliverList(
      delegate: SliverChildListDelegate([
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Divider(),
        ),
      ]),
    );
  }

  Widget _commentsSliver() {
    return BlocBuilder<CommentsBloc, CommentsState>(builder: (context, state) {
      if (state is CommentsInitial) {
        return SliverList(
          delegate: SliverChildListDelegate(
            [
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      }
      if (state is CommentsError) {
        print(state.failure.code);
        return SliverList(
            delegate: SliverChildListDelegate([
          Center(
            child: Text(state.failure.message),
          ),
        ]));
      }
      if (state is CommentsEmpty) {
        return SliverList(
          delegate: SliverChildListDelegate(
            [
              const Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Center(
                  child: Text('no comments'),
                ),
              ),
            ],
          ),
        );
      }
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index >= state.comments.length && state is CommentsReachedMax) {
              return Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: const Align(
                      child: Text('No more comments :/'),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              );
            } else if (index >= state.comments.length &&
                state is CommentsLoaded) {
              return BottomLoader();
            } else {
              return CommentCard(
                comment: state.comments[index],
                chevronCallback: _showCommentDialog,
              );
            }
          },
          childCount: state.comments.length + 1,
        ),
      );

      //return const SliverPadding(padding: EdgeInsets.all(0));
    });
  }

  Widget _buildCommentComposer() {
    return IconTheme(
      data: IconThemeData(
        color: _isCommenting
            ? Theme.of(context).accentColor
            : Theme.of(context).disabledColor,
      ),
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                controller: _commentController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (comment) {
                  setState(() {
                    _isCommenting = comment.isNotEmpty;
                  });
                },
                decoration: const InputDecoration.collapsed(
                    hintText: 'Write a comment...'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Color(0xffce7224),
                ),
                onPressed: () {
                  if (_isCommenting) {
                    _addComment();
                    _commentController.clear();
                    setState(() {
                      _isCommenting = false;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
