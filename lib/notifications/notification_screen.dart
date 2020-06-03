import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:ut_social/core/widgets/main_app_bar.dart';

import 'notification_tile.dart';

List<Map<String, dynamic>> notifications = [
  {
    'body': 'Jane Welch sent you a message',
    'url':
        'https://images.unsplash.com/photo-1589646921364-2cf69fcf4c24?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyNDY2MH0&auto=format&fit=crop&w=1350&q=80'
  },
  {
    'body':
        'Monthly Test - This is a test of the UT Austin emergency notifications system',
    'url':
        'https://i.pinimg.com/originals/a9/7b/2b/a97b2b1b5c12bb7d38024553a81eda40.jpg',
  },
  {
    'body': 'Tennis Bros has 4 new messages',
    'url':
        'https://images.unsplash.com/flagged/photo-1576972405668-2d020a01cbfa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1353&q=80'
  },
  {
    'body': 'Your post was liked 12 times',
    'url':
        'https://apps.shopifycdn.com/listing_images/62a91742b8ec81931cdcfbbfe17e13c2/icon/d3f6ca21f5539ba10ff71b4a43f449a9.png',
  },
];

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _sectionHeader(leading: 'Notifications'),
          _notificationList(),
        ],
      ),
    );
  }

  Widget _notificationList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return NotificationTile(
          title: notifications[index]['body'] as String,
          margin: const EdgeInsets.only(bottom: 6),
          imageUrl: notifications[index]['url'] as String,
          icon: notifications[index]['icon'] as Icon,
          onTap: null,
        );
      }, childCount: notifications.length),
    );
  }

  Widget _sectionHeader({String leading = ''}) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Container(
            padding: EdgeInsets.fromLTRB(18, 22, 18, 22),
            width: double.infinity,
            child: Text(
              leading,
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            )),
      ]),
    );
  }
}
