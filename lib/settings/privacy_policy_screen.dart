import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          'Privacy Policy',
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Privacy Notice',
                style: Theme.of(context).textTheme.headline5),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Last Updated June 20th, 2020',
                style: Theme.of(context).textTheme.subtitle1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'Thank you for choosing to be part of our community at UT Social. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about our notice, or our practices with regards to your personal information, please contact us at getutsocial@gmail.com.',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'When you visit our mobile application, and use our services, you trust us with your personal information. We take your privacy very seriously. In this privacy notice, we seek to explain to you in the clearest way possible what information we collect, how we use it and what rights you have in relation to it. We hope you take some time to read through it carefully, as it is important. If there are any terms in this privacy notice that you do not agree with, please discontinue use of our Apps and our services.',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'This privacy notice applies to all information collected through our mobile application, and/or any related services, sales, marketing or events (we refer to them collectively in this privacy notice as the "**Services**").',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'Please read this privacy notice carefully as it will help you make informed decisions about sharing your personal information with us.',
                style: Theme.of(context).textTheme.headline6),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('1. WHAT INFORMATION DO WE COLLECT?',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'In Short:  Some information — such as IP address and/or browser and device characteristics — is collected automatically when you visit our Apps.',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'We automatically collect certain information when you visit, use or navigate the Apps. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as your IP address, browser and device characteristics, operating system, language preferences, referring URLs, device name, country, location, information about how and when you use our Apps and other technical information. This information is primarily needed to maintain the security and operation of our Apps, and for our internal analytics and reporting purposes.',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('INFORMATION COLLECTED THROUGH OUR APPS',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                'If you use our Apps, we may also collect the following information:',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                ' - Mobile Device Access. We may request access or permission to certain features from your mobile device, including your mobile device\'s camera and contacts, and other features. If you wish to change our access or permissions, you may do so in your device\'s settings.',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                ' - Mobile Device Data. We may automatically collect device information (such as your mobile device ID, model and manufacturer), operating system, version information and IP address.',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                ' - Push Notifications. We may request to send you push notifications regarding your account or the mobile application. If you wish to opt-out from receiving these types of communications, you may turn them off in your device\'s settings.',
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      )),
    );
  }
}
