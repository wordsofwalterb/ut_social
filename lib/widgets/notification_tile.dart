import 'package:flutter/material.dart';

import 'profile_avatar.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String body;
  final Icon icon;
  final String imageUrl;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const NotificationTile({
    this.title,
    this.body,
    this.icon,
    this.imageUrl,
    this.onTap,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: const Color(0xff2e3035),
        margin: margin,
        padding: padding,
        child: ListTile(
          leading: (imageUrl != null)
              ? ProfileAvatar(
                  avatarUrl: imageUrl,
                )
              : IconButton(
                  icon: icon,
                  onPressed: null,
                ),
          title: Text(
            title,
            style: const TextStyle(
              color: Color(0xffffffff),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Text(
            body,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
