import 'package:flutter/material.dart';
import 'package:ut_social/util/router.dart';

import 'package:ut_social/widgets/main_app_bar.dart';

import '../widgets/chat_tile.dart';
import '../widgets/group_card.dart';

List<Map<String, dynamic>> groups = [
  {
    'name': 'Tennis',
    'url':
        'https://images.unsplash.com/flagged/photo-1576972405668-2d020a01cbfa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1353&q=80',
    'count': 25
  },
  {
    'body': 'Gamers',
    'url':
        'https://images.unsplash.com/photo-1542751371-adc38448a05e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'count': 105,
  },
  {
    'body': 'Startups',
    'url':
        'https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'count': 42
  },
  {
    'body': 'Epic Memes',
    'url':
        'https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'count': 256,
  },
];

List<Map<String, dynamic>> chats = [
  {
    'body': 'Jane Welch',
    'url':
        'https://images.unsplash.com/photo-1589646921364-2cf69fcf4c24?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyNDY2MH0&auto=format&fit=crop&w=1350&q=80',
    'message': 'Hey! What are you up to this afternoon?',
    'count': 2,
  },
  {
    'body': 'Gamers',
    'url':
        'https://images.unsplash.com/photo-1542751371-adc38448a05e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'message': 'Joe Rogan: Have you guys tried the new modern warfare?',
    'count': 3,
  },
  {
    'body': 'Startups',
    'url':
        'https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'message':
        'Brent Miller: So here is what I was thinking, we could find a way to take all the old parts people are not using anymore and sell them.',
    'count': 0,
  },
  {
    'body': 'Epic Memes',
    'url':
        'https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
    'message': 'Amy Santos: posted a picture',
    'count': 0,
  },
  {
    'body': 'Tennis',
    'url':
        'https://images.unsplash.com/flagged/photo-1576972405668-2d020a01cbfa?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1353&q=80',
    'message': 'Mary Ricon: Yeah i\'m down',
    'count': 0,
  },
  {
    'body': 'Jake Shepperd',
    'url':
        'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=635&q=80',
    'message': 'Jake Shepperd sent an image',
    'count': 0,
  },
];

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
          _sectionHeader(leading: 'Your group hubs', trailing: 'View All'),
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
              padding: const EdgeInsets.symmetric(),
              itemCount: groups.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return const Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: GroupCard(
                      title: 'Create Group',
                    ),
                  );
                }
                return GroupCard(
                  title: groups[index]['body'] as String,
                  subtitle: '${groups[index]['count']} members',
                  imageUrl: groups[index]['url'] as String,
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
          title: chats[index]['body'] as String,
          subtitle: chats[index]['message'] as String,
          lastMessageDate: DateTime.now(),
          imageUrl: chats[index]['url'] as String,
          numUnreadMessages: chats[index]['count'] as int,
          margin: const EdgeInsets.only(bottom: 6),
          onTap: () => Navigator.of(context).pushNamed(Routes.chatDetail),
        );
      }, childCount: chats.length),
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
                      color: const Color(0xffcbcbcb),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ) ??
                  Container(),
            ),
            const Spacer(),
            Container(
              child: Text(
                trailing,
                style: TextStyle(
                  fontFamily: 'SFProText',
                  color: const Color(0xffcbcbcb),
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
