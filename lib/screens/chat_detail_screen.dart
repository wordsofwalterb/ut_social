import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import '../widgets/chat__message.dart';
import '../widgets/chat_input.dart';

class ChatDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Test Chat',
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 1,
        actions: <Widget>[
          const IconButton(
            onPressed: null,
            icon: Icon(
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
              const ChatInput(),
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
            return const SizedBox(
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
