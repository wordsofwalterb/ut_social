import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/models/student.dart';
import 'package:ut_social/util/router.dart';

import '../blocs/user_bloc/user_bloc.dart';
import 'profile_avatar.dart';

//test
PreferredSizeWidget mainAppBar(BuildContext context) {
  final userBlocState = BlocProvider.of<UserBloc>(context).state;
  Student currentUser;
  if (userBlocState is UserAuthenticated) {
    currentUser = userBlocState.currentUser;
  }
  return AppBar(
    elevation: 2,
    centerTitle: true,
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
    title: Container(
        width: 75,
        child: Image.asset('assets/images/appbar.png', fit: BoxFit.scaleDown)),
    backgroundColor: Theme.of(context).backgroundColor,
    actions: <Widget>[
      // IconButton(
      //   icon: const Icon(Icons.exit_to_app),
      //   onPressed: () {
      //     BlocProvider.of<UserBloc>(context).add(
      //       LogOutUser(),
      //     );
      //   },
      // )
    ],
  );
}
