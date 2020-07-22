import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/blocs/post_bloc/post_bloc.dart';

import 'package:ut_social/models/post.dart';
import 'package:ut_social/util/router.dart';

import 'package:ut_social/widgets/bottom_loader.dart';

import '../widgets/main_app_bar.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  final ScrollController feedController;

  const FeedScreen({this.feedController});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin<FeedScreen> {
  ScrollController _feedController;
  final _scrollThreshold = 200.0;
  PostsBloc _postBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _feedController = widget.feedController;
    _feedController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostsBloc>(context);
  }

  void _onScroll() {
    final maxScroll = _feedController.position.maxScrollExtent;
    final currentScroll = _feedController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(FetchPosts());
    }
  }

  Future<void> _onRefresh() async {
    _postBloc.add(RefreshPosts());
  }

  void _showPostDialog(bool byCurrentUser, Post post) {
    return Platform.isIOS
        ? _iosBottomSheet(byCurrentUser, post)
        : _androidDialog(byCurrentUser, post);
  }

  void _iosBottomSheet(bool byCurrentUser, Post post) {
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

  void _androidDialog(bool byCurrentUser, Post post) {
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

  Future<void> _deletePost(BuildContext context, Post post) async {
    Navigator.pop(context);
    _postBloc.add(DeletePost(post));
  }

  Future<void> _reportPost() async {}

  @override
  void dispose() {
    _feedController.dispose();
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _postBloc = BlocProvider.of<PostsBloc>(context);
    return Scaffold(
      appBar: mainAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(Routes.createPost, arguments: _postBloc),
        backgroundColor: Theme.of(context).backgroundColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _feedController,
          slivers: <Widget>[
            _onYourMind(),
            _postList(),
          ],
        ),
      ),
    );
  }

  Widget _onYourMind() {
    return SliverList(
      delegate: SliverChildListDelegate([
        GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(Routes.createPost, arguments: _postBloc),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
            width: MediaQuery.of(context).size.width,
            height: 45,
            margin: const EdgeInsets.fromLTRB(8, 14, 8, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('What\'s on your mind?',
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, postState) {
      if (postState is PostsInitial) {
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
      if (postState is PostsError) {
        return SliverList(
            delegate: SliverChildListDelegate([
          const Center(
            child: Text('failed to fetch posts'),
          ),
        ]));
      }
      if (postState is PostsEmpty) {
        return SliverList(
            delegate: SliverChildListDelegate([
          const Center(
            child: Text('no posts'),
          ),
        ]));
      }
      if (postState is PostsLoaded || postState is PostsReachedMax) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index >= postState.posts.length &&
                  postState is PostsReachedMax) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: const Align(
                    child: Text('No more posts :/'),
                  ),
                );
              } else if (index >= postState.posts.length &&
                  postState is PostsLoaded) {
                return BottomLoader();
              } else {
                return PostCard(
                  onChevronTap: _showPostDialog,
                  post: postState.posts[index],
                );
              }
            },
            childCount: postState.posts.length + 1,
          ),
        );
      }
      return const SliverPadding(padding: EdgeInsets.all(0));
    });
  }
}
