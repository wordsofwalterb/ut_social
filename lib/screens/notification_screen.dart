import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:ut_social/blocs/notifications_bloc/notifications_bloc.dart';
import 'package:ut_social/util/helper.dart';
import 'package:ut_social/widgets/main_app_bar.dart';

import '../widgets/notification_tile.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsBloc _notificationBloc;

  @override
  Widget build(BuildContext context) {
    _notificationBloc = BlocProvider.of<NotificationsBloc>(context);
    return Scaffold(
      appBar: mainAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async => _notificationBloc.add(BootstrapNotifications()),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            _sectionHeader(leading: 'Notifications'),
            _notificationList(),
          ],
        ),
      ),
    );
  }

  Widget _notificationList() {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (BuildContext context, state) {
      final currentState = state;

      if (currentState is NotificationsReachedMax) {
        print(currentState.notifications);
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return NotificationTile(
              title: currentState.notifications[index].body,
              body: Helper.convertTime(
                  currentState.notifications[index].timestamp),
              margin: const EdgeInsets.only(bottom: 6),
              imageUrl: currentState.notifications[index].imageUrl,
              icon: Icon(SFSymbols.chat_bubble),
              onTap: null,
            );
          }, childCount: currentState.notifications.length),
        );
      }

      if (currentState is NotificationsLoaded) {
        return SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return NotificationTile(
              title: currentState.notifications[index].body,
              body: Helper.convertTime(
                  currentState.notifications[index].timestamp),
              margin: const EdgeInsets.only(bottom: 6),
              imageUrl: currentState.notifications[index].imageUrl,
              icon: Icon(SFSymbols.chat_bubble),
            );
          }, childCount: currentState.notifications.length),
        );
      }

      if (currentState is NotificationsError) {
        return const SliverList(
          delegate: SliverChildListDelegate.fixed([
            Text('There was a problem returning notificaitons'),
          ]),
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
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
            width: double.infinity,
            child: Text(
              leading,
              style: TextStyle(
                color: const Color(0xffffffff),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            )),
      ]),
    );
  }
}
