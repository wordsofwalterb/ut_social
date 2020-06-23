import 'package:flutter/material.dart';

class AuthenticationSettingsScreen extends StatefulWidget {
  @override
  _AuthenticationSettingsScreenState createState() =>
      _AuthenticationSettingsScreenState();
}

class _AuthenticationSettingsScreenState
    extends State<AuthenticationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          'Authentication',
        ),
      ),
    );
  }
}
