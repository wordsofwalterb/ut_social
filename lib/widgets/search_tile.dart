import 'package:flutter/material.dart';

import 'profile_avatar.dart';

class SearchTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  const SearchTile({
    this.name,
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
          leading: ProfileAvatar(
            avatarUrl: imageUrl,
          ),
          title: Text(
            name,
            style: const TextStyle(
              color: Color(0xffcbcbcb),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
