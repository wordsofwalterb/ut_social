import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/entities/post.dart';
import '../core/widgets/comment_card.dart';
import '../core/widgets/post_card.dart';
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

  @override
  void initState() {
    BlocProvider.of<CommentBloc>(context)
        .add(CommentSetup(widget._post.postId));
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _setupFeed() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _setupFeed,
              color: Theme.of(context).primaryColor,
              child: CustomScrollView(
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
                return Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('No more posts :/'),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
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
    });
  }

  void _addComment() {
    BlocProvider.of<CommentBloc>(context)
        .add(CommentAdded(_commentController.text));
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
  }
}
