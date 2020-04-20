import 'package:flutter/material.dart';

class FyreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      child: FlatButton(
        onPressed: () => {},
        color: Colors.blue,
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
