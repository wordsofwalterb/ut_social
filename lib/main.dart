import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/blocs/authentication_bloc/authentication_bloc.dart';
import 'core/blocs/simple_bloc_delegate.dart';
import 'core/home_screen.dart';
import 'core/repositories/user_repository.dart';
import 'core/splash_screen.dart';
import 'core/util/dark_theme.dart';
import 'login/login_screen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final UserRepository userRepository = UserRepository();

  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthAppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fyrefly',
      debugShowCheckedModeBanner: false,
      theme: darkTheme(),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthInitial) {
            return SplashScreen();
          }
          if (state is AuthAuthenticated) {
            return HomeScreen();
          }
          if (state is AuthUnauthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          return LoginScreen(
            userRepository: _userRepository,
          );
        },
      ),
    );
  }
}
