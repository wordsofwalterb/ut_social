import 'package:flutter/material.dart';

class NewContentScreen extends StatefulWidget {
  @override
  _NewContentScreenState createState() => _NewContentScreenState();
}

class _NewContentScreenState extends State<NewContentScreen> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          Text('Post'),
        ],
      ),
      body: Container(
        child: Text('hello'),
      ),
    );
  }
}
