import 'package:flutter/material.dart';
import 'package:ut_social/core/util/router.dart';
import 'package:ut_social/core/widgets/main_app_bar.dart';

import 'chat_tile.dart';
import 'group_card.dart';

class ChatOverviewScreen extends StatefulWidget {
  @override
  _ChatOverviewScreenState createState() => _ChatOverviewScreenState();
}

class _ChatOverviewScreenState extends State<ChatOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          _sectionHeader(leading: 'Join a Group', trailing: 'View All'),
          _groupSection(),
          _sectionHeader(leading: 'Chats'),
          _chatSection(),
        ],
      ),
    );
  }

  Widget _groupSection() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          height: 135,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 0),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: GroupCard(
                      title: 'Create Group',
                    ),
                  );
                }
                return GroupCard(
                  title: 'Delta Sigma Pi',
                  subtitle: '3 members',
                  imageUrl: 'https://placeimg.com/480/480/any',
                );
              }),
        )
      ]),
    );
  }

  Widget _chatSection() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return ChatTile(
          title: 'Test Group',
          subtitle: 'This is an example subtitle',
          lastMessageDate: DateTime.now(),
          numUnreadMessages: 9,
          margin: const EdgeInsets.only(bottom: 6),
          onTap: () => Navigator.of(context).pushNamed(Routes.chatDetail),
        );
      }, childCount: 10),
    );
  }

  Widget _sectionHeader({String trailing = '', String leading = ''}) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 28, 12, 12),
          child: Row(children: [
            Container(
              child: Text(
                    leading,
                    style: TextStyle(
                      fontFamily: 'SFProText',
                      color: Color(0xffcbcbcb),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ) ??
                  Container(),
            ),
            Spacer(),
            Container(
              child: Text(
                trailing,
                style: TextStyle(
                  fontFamily: 'SFProText',
                  color: Color(0xffcbcbcb),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
