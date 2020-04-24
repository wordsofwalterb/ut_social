import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/add_content/add_post.dart';
import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/feed/bloc/post_bloc.dart';
import 'package:ut_social/feed/post_repository.dart';

import '../core/widgets/main_app_bar.dart';
import '../core/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _feedController = ScrollController();
  final _scrollThreshold = 200.0;
  PostBloc _postBloc;

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
    _postBloc.add(PostSetup());
  }

  @override
  void dispose() {
    _feedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: RefreshIndicator(
        color: Theme.of(context).primaryColor,
        onRefresh: _onRefresh,
        child: CustomScrollView(
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
                    style: Theme.of(context).textTheme.bodyText2),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _postList() {
    return BlocBuilder<PostBloc, PostState>(builder: (context, postState) {
      if (postState is PostInitial) {
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
      if (postState is PostError) {
        return SliverList(
            delegate: SliverChildListDelegate([
          Center(
            child: Text('failed to fetch posts'),
          ),
        ]));
      }
      if (postState is PostLoaded) {
        if (postState.posts.isEmpty) {
          return SliverList(
              delegate: SliverChildListDelegate([
            Center(
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
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('No more posts :/'),
                  ),
                );
              } else if (index >= postState.posts.length) {
                return BottomLoader();
              } else {
                // return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                //     builder: (context, state) {
                //   if (state is AuthAuthenticated) {
                //     var likeCount = postState.posts[index].likeCount;
                //     var _isLiked = state.currentUser.likedPosts
                //         .contains(postState.posts[index].postId);
                return PostCard(
                  post: postState.posts[index],
                );
              }
              // });
              // }
            },
            childCount: postState.posts.length + 1,
          ),
        );
      }
      return SliverPadding(padding: const EdgeInsets.all(0));
    });
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}
