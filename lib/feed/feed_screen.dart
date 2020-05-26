import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/add_content/add_post.dart';
import 'package:ut_social/core/util/router.dart';
import 'package:ut_social/core/widgets/bottom_loader.dart';

import 'package:ut_social/feed/post_bloc/post_bloc.dart';

import '../core/widgets/main_app_bar.dart';
import '../core/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin<FeedScreen> {
  final _feedController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _feedController.addListener(_onScroll);
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  void _onScroll() {
    final maxScroll = _feedController.position.maxScrollExtent;
    final currentScroll = _feedController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(PostsFetch());
    }
  }

  Future<void> _onRefresh() async {
    _postBloc.add(PostRefresh());
  }

  @override
  void dispose() {
    _feedController.dispose();
    _postBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _postBloc = BlocProvider.of<PostBloc>(context);
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
    return BlocBuilder<PostBloc, PostState>(condition: (previousState, state) {
      //Initial Setup
      if (previousState is PostInitial) {
        return true;
      }
      // When Fetching Posts
      if (previousState is PostLoaded && state is PostLoaded) {
        if (state.loadingMore == true) return true;
      }
      // When refreshing feed
      if (previousState is PostLoaded && state is PostLoaded) {
        if (state.isRefreshed == true) return true;
        if (previousState.firstPostTime != state.firstPostTime) return true;
      }
      //Default
      return false;
    }, builder: (context, postState) {
      if (postState is PostInitial) {
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
      if (postState is PostError) {
        return SliverList(
            delegate: SliverChildListDelegate([
          const Center(
            child: Text('failed to fetch posts'),
          ),
        ]));
      }
      if (postState is PostLoaded) {
        if (postState.posts.isEmpty) {
          return SliverList(
              delegate: SliverChildListDelegate([
            const Center(
              child: Text('no posts'),
            ),
          ]));
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index >= postState.posts.length && postState.hasReachedMax) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text('No more posts :/'),
                  ),
                );
              } else if (index >= postState.posts.length) {
                return BottomLoader();
              } else {
                return PostCard(
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
