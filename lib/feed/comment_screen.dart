import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';

import '../core/entities/post.dart';
import '../core/widgets/comment_card.dart';
import '../core/widgets/post_card.dart';
import './bottom_loader.dart';
import 'comment_bloc/comment_bloc.dart';

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

  @override
  void initState() {
    BlocProvider.of<CommentsBloc>(context).add(const CommentsSetup());
    _feedController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _feedController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _feedController.position.maxScrollExtent;
    final currentScroll = _feedController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<CommentsBloc>(context).add(CommentsFetched());
    }
  }

  void _addComment() {
    final authBlocState = BlocProvider.of<AuthenticationBloc>(context).state;
    if (authBlocState is AuthAuthenticated) {
      BlocProvider.of<CommentsBloc>(context).add(
        CommentAdded(
          {
            'postId': widget._post.id,
            'body': _commentController.text,
            'authorName': authBlocState.currentUser.fullName,
            'authorId': authBlocState.currentUser.id
          },
        ),
      );
    }
  }

  Future<void> _refreshFeed() async {
    BlocProvider.of(context).add(CommentsRefreshed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title:
            Center(child: Image.asset('assets/images/appbar.png', height: 40)),
        actions: const <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Report'),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshFeed,
              color: Theme.of(context).primaryColor,
              child: CustomScrollView(
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

  Widget _postSliver() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: PostCard(
            post: widget._post,
            disableComment: true,
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
              const Center(
                child: Text('no comments'),
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
                      alignment: Alignment.center,
                      child: Text('No more posts :/'),
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
                icon: Icon(Icons.send),
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
