import 'package:flutter/material.dart'; // ignore: file_names

class FyreButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0,
      child: FlatButton(
        onPressed: () => {},
        color: Colors.blue,
        padding: const EdgeInsets.all(10.0),
        child: const Text(
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
