import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/core/entities/student.dart';
import 'package:ut_social/core/util/router.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';
import 'profile_avatar.dart';

PreferredSizeWidget mainAppBar(BuildContext context) {
  final authBlocState = BlocProvider.of<AuthenticationBloc>(context).state;
  Student currentUser;
  if (authBlocState is AuthAuthenticated) {
    currentUser = authBlocState.currentUser;
  }
  return AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ProfileAvatar(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.profile,
          arguments: ProfileArgs(currentUser.id, isCurrentUser: true),
        ),
        avatarUrl: currentUser.avatarUrl,
      ),
    ),
    title: Center(
      child: Container(
          width: 75,
          child:
              Image.asset('assets/images/appbar.png', fit: BoxFit.scaleDown)),
    ),
    backgroundColor: Theme.of(context).backgroundColor,
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.exit_to_app),
        onPressed: () {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthLoggedOut(),
          );
        },
      )
    ],
  );
}
