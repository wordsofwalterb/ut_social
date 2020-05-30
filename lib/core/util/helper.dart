import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class Helper {
  static String convertTime(DateTime dateTime) {
    var time = DateTime.now().difference(dateTime).inHours;
    print(time);
    if (time > 24) {
      final formatter = DateFormat('MMM d, y');
      return formatter.format(dateTime);
    }
    return timeago.format(dateTime);
  }

  static InputDecoration textFieldStyle(
      {String labelTextStr = '', String hintTextStr = ''}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
