import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum AvatarOutline {
  none,
  white,
  dark,
}

/// Displays a cached profile avatar
///
/// If [avatarUrl] is null will build using a default image
/// from the assets folder at [defaultImageSrc]
class ProfileAvatar extends StatelessWidget {
  /// The url of the avatar
  final String avatarUrl;

  /// The size of the avatar
  final double size;

  /// The radius of the border
  final double radius;

  /// The src of the default image
  final String defaultImageSrc;

  /// When happens when the profile image is pressed
  final GestureTapCallback onPressed;

  /// The type of outline to apply
  final AvatarOutline outline;

  final Color borderColor;
  final double borderWidth;

  /// Displays a cached profile avatar
  ///
  /// If [avatarUrl] is null will build using a default image
  /// from the assets folder at [defaultImageSrc]
  const ProfileAvatar({
    this.avatarUrl,
    this.size = 37,
    this.radius = 8,
    this.onPressed,
    this.outline,
    this.borderColor,
    this.borderWidth = 0,
    this.defaultImageSrc = 'assets/images/default.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: (avatarUrl != null && avatarUrl != '')
          ? CachedNetworkImage(
              imageUrl: avatarUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  border: (borderColor != null)
                      ? Border.all(
                          color: borderColor,
                          width: borderWidth,
                        )
                      : Border.all(),
                  borderRadius: BorderRadius.circular(radius),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                border: (borderColor != null)
                    ? Border.all(
                        color: borderColor,
                        width: borderWidth,
                      )
                    : Border.all(),
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                  image: AssetImage(
                    defaultImageSrc,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
