import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ut_social/util/dark_theme.dart';

class GroupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const GroupCard({@required this.title, this.subtitle, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 135,
        width: 135,
        decoration: (imageUrl != null)
            ? BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  //colorFilter: ColorFilter.mode(Colors.black12, BlendMode.srcOver),
                  image: CachedNetworkImageProvider(imageUrl),
                ),
              )
            : BoxDecoration(
                gradient: orangeGradient(),
              ),
        child: Stack(
          children: <Widget>[
            if (imageUrl != null) ...{
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    stops: [0, 1],
                    begin: Alignment(-0.00, -1.00),
                    end: Alignment(0.00, 1.00),
                  ),
                ),
              ),
            },
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (subtitle != null) ...{
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        subtitle ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color(0xfff5f5f5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  },
                  const Padding(
                    padding: EdgeInsets.only(bottom: 6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
