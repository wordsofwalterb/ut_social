import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoverPhoto extends StatelessWidget {
  /// The network url of the cover photo
  final String coverPhotoUrl;

  final double height;

  final double width;

  final double radius;

  /// The asset src, file must be in assets
  final String defaultImageSrc;

  const CoverPhoto({
    this.coverPhotoUrl,
    this.height,
    this.width,
    this.radius = 8,
    this.defaultImageSrc = 'assets/images/default.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return (coverPhotoUrl != null && coverPhotoUrl != '')
        ? CachedNetworkImage(
            imageUrl: coverPhotoUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    topRight: Radius.circular(radius)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )
        : Container(
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
  }
}
