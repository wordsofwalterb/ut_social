import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'screens/feed_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  PageController _pageController;
  final ScrollController _feedController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void onFeedIconTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentTab = index;
          });
        },
        children: <Widget>[
          FeedScreen(
            feedController: _feedController,
          ),
          SearchScreen(),
          // NewContentScreen(),
          // ChatOverviewScreen(),
          NotificationScreen(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: _currentTab,
        onTap: (int index) {
          if (_pageController.page == 0 && index == 0)
            _feedController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.linear);
          else {
            setState(() {
              _currentTab = index;
            });
            _pageController.jumpToPage(
              index,
            );
          }
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
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     SFSymbols.plus_square,
          //     size: 34.0,
          //   ),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     SFSymbols.bubble_left,
          //     size: 28.0,
          //   ),
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              SFSymbols.bell,
              size: 28.0,
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
