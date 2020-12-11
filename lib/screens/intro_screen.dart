import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroSlide {
  final String imageUrl;
  final String title;
  final String body;

  IntroSlide({
    @required this.imageUrl,
    @required this.title,
    @required this.body,
  });

  factory IntroSlide.fromMap(Map<String, dynamic> map) {
    return IntroSlide(
      imageUrl: map['imageUrl'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final controller = PageController(viewportFraction: 0.8);

  final slides = [
    {
      'imageUrl':
          'https://firebasestorage.googleapis.com/v0/b/fyrefly-dev.appspot.com/o/intro_slides%2FGroup%2070.png?alt=media&token=ecf40741-1c68-4502-b4c4-4c587882e744',
      'title': 'Talk with UT Community',
      'body':
          "Show your best memes, ask for advice, and see what's happening on campus",
    },
    {
      'imageUrl':
          'https://firebasestorage.googleapis.com/v0/b/fyrefly-dev.appspot.com/o/intro_slides%2FGroup%2073.png?alt=media&token=93838072-0b0e-4689-8b5b-a116537a5c8b',
      'title': 'Discover UT-Austin',
      'body': 'Find events and interest groups on campus',
    },
    {
      'imageUrl':
          'https://firebasestorage.googleapis.com/v0/b/fyrefly-dev.appspot.com/o/intro_slides%2FGroup%2048.png?alt=media&token=37f5b737-2a62-4efb-b832-f9d75ed6dd95',
      'title': 'Join groups and message others',
      'body': 'Message your friends or create groups based on your interest',
    }
  ].map((e) => IntroSlide.fromMap(e)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            SizedBox(
              height: 600,
              child: PageView(
                controller: controller,
                children: List.generate(slides.length,
                    (index) => _buildOverviewSlide(slides[index])),
              ),
            ),
            // SmoothPageIndicator(
            //   controller: controller,
            //   count: slides.length,
            //   effect: ExpandingDotsEffect(
            //     expansionFactor: 4,
            //   ),
            // ),
            FlatButton(
              child: const Text('Join now'),
              //  color:
              onPressed: null,
            ),
            const Text('Have an account already? Log in'),
          ],
        ),
      ),
    ));
  }

  Widget _buildOverviewSlide(IntroSlide data) {
    return Column(
      children: [
        CachedNetworkImage(imageUrl: data.imageUrl),
        SizedBox(height: 20),
        Text(
          data.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Text(
          data.body,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
