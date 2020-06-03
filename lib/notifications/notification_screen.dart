import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:ut_social/core/widgets/main_app_bar.dart';

import 'notification_tile.dart';

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
          title: 'You recieved a new message',
          margin: const EdgeInsets.only(bottom: 6),
          icon: Icon(SFSymbols.bubble_left),
          onTap: null,
        );
      }, childCount: 3),
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
