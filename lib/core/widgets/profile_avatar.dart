import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarOutline {
  none,
  white,
}

/// Takes user to retrieve profile image, if image is not
/// available then uses default image. Optional parameters for
/// width and height.
class ProfileAvatar extends StatelessWidget {
  final String avatarUrl;
  final String userId;
  final double size;
  final AvatarOutline outline;

  const ProfileAvatar(
      {@required this.avatarUrl,
      @required this.userId,
      this.size = 37,
      this.outline = AvatarOutline.none});

  @override
  Widget build(BuildContext context) {
    return (avatarUrl != null && avatarUrl != '')
        ? CachedNetworkImage(
            imageUrl: avatarUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        : Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/default.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  // _boxDecoration() {
  //   switch (outline) {
  //     case AvatarOutline.white:
  //       {
  //         return BoxDecoration(
  //           border: Border.all(width: 1, color: Colors.white),
  //           borderRadius: BorderRadius.circular(8),
  //         );
  //       }

  //     case AvatarOutline.none:
  //       {
  //         return BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //         );
  //       }
  //   }
  // }
}
