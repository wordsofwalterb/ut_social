import 'package:flutter/material.dart';

class AuthenticationSettingsScreen extends StatelessWidget {
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
