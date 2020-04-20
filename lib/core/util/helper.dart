import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static String convertTime(DateTime dateTime) {
    return timeago.format(dateTime);
  }

  static InputDecoration textFieldStyle(
      {String labelTextStr = "", String hintTextStr = ""}) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
