import 'package:flutter/material.dart';
import 'package:ut_social/util/helper.dart';

import 'profile_avatar.dart';

class ChatTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final DateTime lastMessageDate;
  final int numUnreadMessages;
  final String imageUrl;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const ChatTile(
      {@required this.title,
      @required this.subtitle,
      this.onTap,
      this.lastMessageDate,
      this.margin,
      this.padding,
      this.numUnreadMessages,
      this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: const Color(0xff2e3035),
        margin: margin,
        padding: padding,
        child: ListTile(
          leading: ProfileAvatar(
            avatarUrl: imageUrl,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xffcbcbcb),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xffa1a1a1),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (lastMessageDate != null)
                  Text(
                    Helper.convertTime(lastMessageDate),
                    style: const TextStyle(
                      color: Color(0xffa1a1a1),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                if (numUnreadMessages != null && numUnreadMessages != 0)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xffce7224),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      numUnreadMessages.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ]),
        ),
      ),
    );
  }
}
