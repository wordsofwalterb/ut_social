import 'package:flutter/material.dart';

import '../core/util/fake_data.dart';
import '../core/widgets/main_app_bar.dart';
import '../core/widgets/post_card.dart';


class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: CustomScrollView(
        slivers: <Widget>[
          _onYourMind(),
          _postList(),
        ],
      ),
    );
  }

  Widget _onYourMind() {
    return SliverList(
      delegate: SliverChildListDelegate([
        GestureDetector(
          onTap: () => {},
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
          if (index >= fakePosts.length) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text('No more posts :/'),
              ),
            );
          } else {
            return PostCard(post: fakePosts[index]);
          }
        },
        childCount: fakePosts.length + 1,
      ),
    );
  }
}
