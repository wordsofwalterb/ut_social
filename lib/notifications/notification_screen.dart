import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:ut_social/core/blocs/notifications_bloc/notifications_bloc.dart';
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
    return BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (BuildContext context, state) {
      final currentState = state;

      if (currentState is NotificationsReachedMax) {
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return NotificationTile(
              title: currentState.notifications[index].title,
              body: currentState.notifications[index].body ?? '',
              margin: const EdgeInsets.only(bottom: 6),
              imageUrl: currentState.notifications[index].imageUrl,
              icon: Icon(SFSymbols.airplane),
              onTap: null,
            );
          }, childCount: currentState.notifications.length),
        );
      }

      return SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            Container(),
          ],
        ),
      );
    });
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
