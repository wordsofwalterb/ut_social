// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class AppIntroScreen extends StatelessWidget {
//   List<Map<String, dynamic>> slideData = [
//     {
//       'imageUrl':
//           'https://firebasestorage.googleapis.com/v0/b/fyrefly-dev.appspot.com/o/intro_slides%2FGroup%2070.png?alt=media&token=ecf40741-1c68-4502-b4c4-4c587882e744',
//       'title': 'Talk with UT Community',
//       'body':
//           "Show your best memes, ask for advice, and see what's happening on campus.",
//     },
//     {
//       'imageUrl':
//           'https://firebasestorage.googleapis.com/v0/b/fyrefly-dev.appspot.com/o/intro_slides%2FGroup%2073.png?alt=media&token=93838072-0b0e-4689-8b5b-a116537a5c8b',
//       'title': 'Discover UT-Austin',
//       'body': 'Find events and interest groups on campus',
//     },
//     {
//       'imageUrl':
//           'https://firebasestorage.googleapis.com/v0/b/fyrefly-dev.appspot.com/o/intro_slides%2FGroup%2048.png?alt=media&token=37f5b737-2a62-4efb-b832-f9d75ed6dd95',
//       'title': 'Join groups and message others',
//       'body': 'Message your friends or create groups based on your interest.',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           options: CarouselOptions(),
//           items: slideData.map((item) {
//             return Column(
//               children: [
//                 Image.network(
//                   item['imageUrl'].toString(),
//                   height: MediaQuery.of(context).size.height / 3,
//                 ),
//                 Text(item['title'].toString()),
//                 Text(item['body'].toString()),
//                 Row(
//                   children: <Widget>[
//                     ...slideData.map(
//                       (e) => Container(),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
