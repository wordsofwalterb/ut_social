import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

class ChatInput extends StatelessWidget {
  final VoidCallback onImagePressed;
  final VoidCallback onSendPressed;
  final TextEditingController textController;

  const ChatInput({
    this.onImagePressed,
    this.onSendPressed,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 50.0,
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        color: Color(0xff35393f),
      ),
      child: Row(
        children: <Widget>[
          // Button image
          IconButton(
            icon: const Icon(
              SFSymbols.camera_circle_fill,
            ),
            iconSize: 40,
            padding: const EdgeInsets.only(bottom: 3),
            onPressed: onImagePressed,
            color: Theme.of(context).primaryColor,
          ),

          // Edit text
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff202225),
                borderRadius: BorderRadius.circular(22),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 15.0),
                controller: textController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),

          // Button send message
          SizedBox(
            height: 40,
            width: 40,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.white,
                    width: 20,
                    height: 20,
                  ),
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  disabledColor: const Color(0xffcf7c35),
                  icon: const Icon(
                    SFSymbols.arrow_up_circle_fill,
                  ),
                  iconSize: 37,
                  padding: EdgeInsets.zero,
                  onPressed: onSendPressed,
                  //onPressed: () => onSendMessage(textEditingController.text, 0),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
