import 'package:flutter/material.dart';
import 'package:ut_social/core/widgets/profile_avatar.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const NotificationTile({
    this.title,
    this.icon,
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
          leading: IconButton(
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
        ),
      ),
    );
  }
}
