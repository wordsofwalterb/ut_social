import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton(this.text, {this.onPressed, this.width, this.height});

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xff202225),
          border: Border.all(
            color: const Color(0xff424040),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
