import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/core/entities/comment.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/widgets/comment_card.dart';
import 'package:ut_social/core/widgets/post_card.dart';
import 'package:ut_social/feed/comment_repository.dart';
import 'package:ut_social/feed/post_bloc/post_bloc.dart';

import 'comment_bloc/comment_bloc.dart';

class CommentScreen extends StatefulWidget {
  final Post _post;

  CommentScreen(Post post, {Key key})
      : assert(post != null),
        _post = post,
        super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;

  // List<Comment> _comments = [];
  // bool isLoading = true;
  // CommentRepository _repository;

  @override
  void initState() {
    // _repository = FirebaseCommentRepository();
    // _setupFeed();
    BlocProvider.of<CommentBloc>(context)
        .add(CommentSetup(widget._post.postId));
    super.initState();
  }

  Future<void> _setupFeed() async {
    // var newComments = await _repository.setupFeed(widget._post.postId);
    // setState(() {
    //   _comments = newComments;
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildCommentTF(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title:
            Center(child: Image.asset('assets/images/appbar.png', height: 40)),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Report'),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _setupFeed,
        color: Theme.of(context).primaryColor,
        child: CustomScrollView(
          slivers: <Widget>[
            _postSliver(),
            _divider(),
            _commentsSliver(),
            // SliverFillRemaining(fillOverscroll: true,)
            // SliverFillViewport(
            //   delegate: SliverFillViewport,
            // ),
            // _buildCommentTF(),
          ],
        ),
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Divider(),
        ),
      ]),
    );
  }

  Widget _commentsSliver() {
    return BlocBuilder<CommentBloc, CommentState>(builder: (context, state) {
      if (state is CommentInitial) {
        return SliverList(
          delegate: SliverChildListDelegate(
            [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      }
      if (state is CommentError) {
        return SliverList(
            delegate: SliverChildListDelegate([
          Center(
            child: Text('failed to fetch comments'),
          ),
        ]));
      }
      if (state is CommentLoaded) {
        if (state.comments.isEmpty) {
          return SliverList(
              delegate: SliverChildListDelegate([
            Center(
              child: Text('no comments'),
            ),
          ]));
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index >= state.comments.length) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('No more posts :/'),
                  ),
                );
              } else if (index >= state.comments.length) {
                return Container(); //BottomLoader();
              } else {
                return CommentCard(
                  comment: state.comments[index],
                );
              }
            },
            childCount: state.comments.length + 1,
          ),
        );
      }
      return SliverPadding(padding: const EdgeInsets.all(0));

      // return SliverList(
      //   delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      //     if (index >= _comments.length) {
      //       return Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: 50,
      //         child: Align(
      //           alignment: Alignment.center,
      //           child: Text('No more comments :/'),
      //         ),
      //       );
      //     } else {
      //       return CommentCard(
      //         comment: _comments[index],
      //       );
      //     }
      //   }, childCount: _comments.length + 1),
      // );
    });
  }

  void _addComment() {
    BlocProvider.of<CommentBloc>(context)
        .add(CommentAdded(_commentController.text));
  }

  Widget _buildCommentTF() {
    return IconTheme(
      data: IconThemeData(
        color: _isCommenting
            ? Theme.of(context).accentColor
            : Theme.of(context).disabledColor,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                controller: _commentController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (comment) {
                  setState(() {
                    _isCommenting = comment.length > 0;
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: 'Write a comment...'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
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
    //   ]),
    // );
  }
}
