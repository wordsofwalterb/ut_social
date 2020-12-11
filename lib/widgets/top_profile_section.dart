import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/blocs/profile_info_bloc/profile_info_bloc.dart';
import 'package:ut_social/util/router.dart';

import 'cover_photo.dart';
import 'profile_avatar.dart';

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
                    height: 120,
                    coverPhotoUrl: coverPhotoUrl,
                  ),
                ],
              ),
              Positioned(
                bottom: -42,
                left: 15,
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
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          if (bio != null)
            Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(
                bio,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          const SizedBox(height: 8),
          if (isCurrentUser)
            GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.editProfile,
                arguments: BlocProvider.of<ProfileInfoBloc>(context),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
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
