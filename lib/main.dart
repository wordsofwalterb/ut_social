import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ut_social/services/notification_repository.dart';

import 'blocs/notifications_bloc/notifications_bloc.dart';
import 'blocs/post_bloc/post_bloc.dart';
import 'blocs/simple_bloc_observer.dart';
import 'blocs/user_bloc/user_bloc.dart';
import 'home_screen.dart';
import 'screens/login_screen.dart';
import 'services/post_repository.dart';
import 'services/user_repository.dart';
import 'splash_screen.dart';
import 'util/dark_theme.dart';
import 'util/globals.dart';
import 'util/router.dart';
import 'widgets/notification_bridge.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('first_run') ?? true) {
    print('Clearing cache');
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await FirebaseAuth.instance.signOut();

    await storage.deleteAll();

    await prefs.setBool('first_run', false);
  }

  final UserRepository userRepository = UserRepository();

  runApp(
    BlocProvider(
      create: (context) =>
          UserBloc(userRepository: userRepository)..add(InitializeUser()),
      child: OverlaySupport(child: App(userRepository: userRepository)),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({Key key, @required UserRepository userRepository})
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
      onGenerateRoute: Router.generateRoute,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: Global.analytics),
      ],
      home: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            return SplashScreen();
          }
          if (state is UserAuthenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<PostsBloc>(
                  create: (context) => PostsBloc(
                    postRepository: FirebasePostRepository(),
                  )..add(const SetupPosts()),
                ),
                BlocProvider<NotificationsBloc>(
                  create: (context) => NotificationsBloc(
                    FirebaseNotificationRepository(),
                  )..add(BootstrapNotifications()),
                )
              ],
              child: NotificationBridge(
                child: HomeScreen(),
              ),
            );
          }
          if (state is UserUnauthenticated) {
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
