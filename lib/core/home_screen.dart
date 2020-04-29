import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'package:ut_social/core/blocs/authentication_bloc/authentication_bloc.dart';

import 'package:ut_social/feed/post_bloc/post_bloc.dart';
import 'package:ut_social/feed/post_repository.dart';

import '../add_content/new_content_screen.dart';
import '../chats/chat_screen.dart';
import '../feed/feed_screen.dart';
import '../notifications/notification_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(
              postRepository: FirebasePostRepository(),
              authBloc: BlocProvider.of<AuthenticationBloc>(context))
            ..add(PostSetup()),
        ),
      ],
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentTab = index;
            });
          },
          children: <Widget>[
            FeedScreen(),
            SearchScreen(),
            NewContentScreen(),
            ChatScreen(),
            NotificationScreen(),
          ],
        ),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).backgroundColor,
          currentIndex: _currentTab,
          onTap: (int index) {
            setState(() {
              _currentTab = index;
            });
            _pageController.jumpToPage(
              index,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                SFSymbols.rectangle_grid_1x2_fill,
                size: 28.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                SFSymbols.search,
                size: 28.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                SFSymbols.plus_square,
                size: 34.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                SFSymbols.bubble_left,
                size: 28.0,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                SFSymbols.bell,
                size: 28.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
