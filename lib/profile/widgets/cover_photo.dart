import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoverPhoto extends StatelessWidget {
  /// The network url of the cover photo
  final String coverPhotoUrl;

  final double height;

  final double width;

  final double radius;

  final VoidCallback onPressed;

  final FileImage fileImage;

  /// The asset src, file must be in assets
  final String defaultImageSrc;

  const CoverPhoto({
    this.onPressed,
    this.fileImage,
    this.coverPhotoUrl,
    this.height,
    this.width,
    this.radius = 8,
    this.defaultImageSrc = 'assets/images/utCover.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Builder(
        builder: (context) {
          if (fileImage != null) {
            return Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
                image: DecorationImage(
                  image: fileImage,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          if (coverPhotoUrl != null && coverPhotoUrl != '') {
            return CachedNetworkImage(
              imageUrl: coverPhotoUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          }
          // If both fileImage and coverPhotoUrl are null
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius)),
              image: DecorationImage(
                image: AssetImage(
                  defaultImageSrc,
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
