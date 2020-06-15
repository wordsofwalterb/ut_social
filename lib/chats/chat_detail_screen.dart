import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:like_button/like_button.dart';
import 'package:ut_social/chats/chat_input.dart';
import 'package:ut_social/core/widgets/profile_avatar.dart';

import 'chat__message.dart';

class ChatDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Test Chat',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 1,
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: const Icon(
              SFSymbols.ellipsis,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildMessages(),

              // Input content
              ChatInput(),
            ],
          ),

          // Loading
          //  buildLoading()
        ],
      ),
    );
  }

  Widget buildMessages() {
    return Flexible(
      child: ListView.builder(
        itemCount: 4,
        controller: null,
        reverse: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return SizedBox(
              height: 12,
            );
          }
          return ChatMessage(
            name: 'Test Name',
            body:
                'This is a test of the message body, this is testing what happens in the case of longer messages',
            avatarUrl: 'https://placeimg.com/480/480/any',
            timestamp: DateTime.now(),
            //backgroundColor: Theme.of(context).backgroundColor,
          );
        },
      ),
    );
  }
}
