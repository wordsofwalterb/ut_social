import 'package:flutter/material.dart';
import 'package:ut_social/core/widgets/profile_avatar.dart';

import 'widgets/cover_photo.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text(
            'Edit Profile',
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Color(0xffce7224),
                    fontSize: 16,
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _changeImages(),
            _textFields(),
          ]),
        ));
  }

  Widget _changeImages() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 17, 19, 50),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Stack(
            children: [
              CoverPhoto(
                height: 120,
                coverPhotoUrl: '',
              ),
            ],
          ),
          Positioned(
            bottom: -42,
            left: 15,
            child: ProfileAvatar(
              avatarUrl: '',
              radius: 100,
              size: 90,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFields() {
    return Column(children: []);
  }
}
