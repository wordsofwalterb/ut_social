import 'package:flutter/material.dart';
import 'package:ut_social/add_content/add_post.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/feed/post_repository.dart';

import '../core/widgets/main_app_bar.dart';
import '../core/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  ScrollController _scrollController = new ScrollController();
  List<Post> _posts = [];
  FirebasePostRepository _postRepository = FirebasePostRepository();
  bool isLoading = true;
  bool isFetchingMore = false;

  @override
  void initState() {
    isLoading = true;

    _setupFeed();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchPosts();
      }
    });
    super.initState();
  }

  Future<void> _setupFeed() async {
    var results = await _postRepository.setupFeed();
    setState(() {
      _posts = results;
      isLoading = false;
    });
  }

  Future<void> _fetchPosts() async {
    setState(() {
      isFetchingMore = true;
    });
    var results = await _postRepository.fetchNextPage(
        startAfter: _posts.last.postTime, limit: 10);
    setState(() {
      _posts.addAll(results);
      isFetchingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: _setupFeed,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            _onYourMind(),
            (isLoading)
                ? SliverList(
                    delegate: SliverChildListDelegate([Container()]),
                  )
                : _postList(),
          ],
        ),
      ),
    );
  }

  Widget _onYourMind() {
    return SliverList(
      delegate: SliverChildListDelegate([
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return CreatePostScreen();
            }),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
            width: MediaQuery.of(context).size.width,
            height: 45,
            margin: EdgeInsets.fromLTRB(8, 14, 8, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('What\'s on your mind?',
                    style: Theme.of(context).textTheme.body2),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _postList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index >= _posts.length) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text('No more posts :/'),
              ),
            );
          } else {
            return PostCard(post: _posts[index]);
          }
        },
        childCount: _posts.length + 1,
      ),
    );
  }
}
