import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/core/entities/comment.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/widgets/comment_card.dart';
import 'package:ut_social/core/widgets/post_card.dart';
import 'package:ut_social/feed/comment_repository.dart';
import 'package:ut_social/feed/post_bloc/post_bloc.dart';

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
  List<Comment> _comments = [];
  bool isLoading = true;
  CommentRepository _repository;

  @override
  void initState() {
    _repository = FirebaseCommentRepository();
    _setupFeed();
    super.initState();
  }

  Future<void> _setupFeed() async {
    var newComments = await _repository.setupFeed();
    setState(() {
      _comments = newComments;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Image.asset('assets/images/appbar.png', height: 40),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Report'),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _setupFeed,
        color: Theme.of(context).primaryColor,
        child: CustomScrollView(
          slivers: <Widget>[
            _postSliver(),
            // _divider(),
            // _commentsSliver(),
          ],
        ),
      ),
    );
  }

  Widget _postSliver() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(8.0),
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

  Widget _getBody() {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/sample.jpg"), fit: BoxFit.fitWidth)),
        // color: Color.fromARGB(50, 200, 50, 20),
        child: Column(
          children: <Widget>[TextField()],
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        right: 0,
        child: Container(
          height: 50,
          child: Text("Hiiiii"),
          decoration: BoxDecoration(color: Colors.pink),
        ),
      ),
    ]);
  }

  Widget _commentsSliver() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        if (index >= _comments.length) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Align(
              alignment: Alignment.center,
              child: Text('No more comments :/'),
            ),
          );
        } else {
          return CommentCard(
            comment: _comments[index],
          );
        }
      }, childCount: _comments.length + 1),
    );
  }
}
