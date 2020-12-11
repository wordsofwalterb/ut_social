import 'package:flutter/material.dart';

class NewContentScreen extends StatefulWidget {
  @override
  _NewContentScreenState createState() => _NewContentScreenState();
}

class _NewContentScreenState extends State<NewContentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: const <Widget>[
          Text('Post'),
        ],
      ),
      body: const Text('hello'),
    );
  }
}
