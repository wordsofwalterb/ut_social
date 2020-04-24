import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';
import 'profile_avatar.dart';


PreferredSizeWidget mainAppBar(BuildContext context) {
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ProfileAvatar(avatarUrl: '', userId: '1'),
    ),
    title: Center(
      child: Container(
        width: 75,
        child: Image.asset('assets/images/appbar.png', fit: BoxFit.scaleDown)),
    ),
    backgroundColor: Theme.of(context).backgroundColor,
    actions: <Widget>[
      IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthLoggedOut(),
              );
            },
          )
    ],
  );
}
