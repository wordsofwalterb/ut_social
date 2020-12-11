import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'screens/chat_overview_screen.dart';
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
  ScrollController _feedController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _feedController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _feedController.dispose();
  }

  void _onNavItemTapped(int indexTapped) {
    if (_pageController.page == 0 && indexTapped == 0) {
      _feedController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    } else {
      setState(() {
        _currentTab = indexTapped;
      });
      _pageController.jumpToPage(
        indexTapped,
      );
    }
  }

  void _onPageChanged(int newIndex) {
    setState(() {
      _currentTab = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          FeedScreen(
            feedController: _feedController,
          ),
          SearchScreen(),
          ChatOverviewScreen(),
          NotificationScreen(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: _currentTab,
        onTap: _onNavItemTapped,
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
    );
  }
}
