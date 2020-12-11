import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';

class SettingsOverviewScreen extends StatefulWidget {
  @override
  _SettingsOverviewScreenState createState() => _SettingsOverviewScreenState();
}

class _SettingsOverviewScreenState extends State<SettingsOverviewScreen> {
  bool _notificationsEnabled = false;
  UserBloc _userBloc;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> _launchPrivacyPolicy() async {
    const url =
        'https://www.notion.so/Privacy-Policy-1dc7732fb3f04de3810fe66c984bb431';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchTermsOfService() async {
    const url =
        'https://www.notion.so/Terms-of-Services-b7c41ba68be74edcb8c065c1f9c5d4c0';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    final UserState userState = _userBloc.state;
    if (userState is UserAuthenticated) {
      _notificationsEnabled = userState.currentUser.notificationsEnabled;
    }
  }

  void _toggleNotificationSwitch(bool value) {
    _userBloc.add(UpdateUserProfile(notificationsEnabled: value));

    if (value) {
      _fcm.requestNotificationPermissions(const IosNotificationSettings());
    }

    setState(() {
      _notificationsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const SizedBox(height: 26),
            // _buildSubheader('General'),
            // const SizedBox(height: 26),
            // _buildListTile('Authentication',
            //     onTap: () => Navigator.of(context)
            //         .pushNamed(Routes.authenticationSettings)),
            const SizedBox(height: 26),
            _buildSubheader('Notifications'),
            const SizedBox(height: 26),
            _buildListTile(
              'Notifications',
              trailing: Switch.adaptive(
                  activeColor: const Color(0xffce7224),
                  value: _notificationsEnabled,
                  onChanged: _toggleNotificationSwitch),
            ),
            const SizedBox(height: 26),
            _buildSubheader('Other'),
            const SizedBox(height: 26),
            _buildListTile(
              'Terms of Service',
              onTap: _launchTermsOfService,
            ),
            const SizedBox(height: 5),
            _buildListTile(
              'Privacy Policy',
              onTap: _launchPrivacyPolicy,
            ),
            const SizedBox(height: 35),
            _buildListTile(
              'Logout',
              onTap: () {
                BlocProvider.of<UserBloc>(context).add(LogOutUser());
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubheader(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xffcbcbcb),
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildListTile(String text, {VoidCallback onTap, Widget trailing}) {
    return Container(
      color: const Color(0xff2e3035),
      child: ListTile(
        trailing: trailing ?? Icon(SFSymbols.chevron_right),
        onTap: onTap,
        title: Text(
          text,
          style: TextStyle(
            color: const Color(0xffcbcbcb),
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
