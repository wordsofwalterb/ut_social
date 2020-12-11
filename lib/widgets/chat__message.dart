import 'package:flutter/material.dart';
import 'package:ut_social/util/helper.dart';

import 'profile_avatar.dart';

class ChatMessage extends StatelessWidget {
  final String name;
  final String body;
  final DateTime timestamp;
  final Color backgroundColor;
  final String avatarUrl;

  const ChatMessage({
    this.avatarUrl,
    this.name,
    this.body,
    this.timestamp,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatar(
            avatarUrl: avatarUrl,
            size: 38,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xfff1f1f1),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        Helper.convertTimeToHourMinute(timestamp),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: const Color(0xff8e8e8e),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    body,
                    softWrap: true,
                    style: TextStyle(
                      color: const Color(0xfff1f1f1),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
