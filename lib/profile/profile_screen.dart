import 'package:flutter/material.dart';
import 'package:ut_social/profile/top_profile_section.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                TopProfileSection(
                  isCurrentUser: false,
                  name: 'Brandon Walter',
                  bio: 'This is Brandon and I have a bio '
                      'here that I want to share',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
