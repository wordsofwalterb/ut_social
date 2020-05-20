import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ut_social/core/widgets/profile_avatar.dart';

import 'cover_photo.dart';

/// This widget displays the main overview information about a user
class TopProfileSection extends StatelessWidget {
  final String coverPhotoUrl;
  final bool isCurrentUser;
  final String avatarUrl;
  final String name;
  final String bio;
  final bool isFollowed;
  final Function onFollow;
  final Function onMessage;

  const TopProfileSection(
      {this.coverPhotoUrl,
      this.avatarUrl,
      this.bio,
      @required this.isCurrentUser,
      this.isFollowed,
      @required this.name,
      this.onFollow,
      this.onMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Stack(
                children: [
                  CoverPhoto(
                    height: 100,
                    coverPhotoUrl: coverPhotoUrl,
                  ),
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: IconButton(
                  //       color: Colors.white,
                  //       icon: const Icon(SFSymbols.chevron_down),
                  //       onPressed: () => {},
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Positioned(
                bottom: -42,
                left: 10,
                child: ProfileAvatar(
                  avatarUrl: avatarUrl,
                  borderWidth: 4,
                  borderColor: Theme.of(context).backgroundColor,
                  radius: 100,
                  size: 90,
                ),
              ),
            ],
          ),
          const SizedBox(height: 42),
          Container(
            margin: const EdgeInsets.all(8),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: Text(
              bio ?? '',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1,
                  color: const Color(0xff424040),
                ),
              ),
              child: const Text(
                'Edit Profile',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}
