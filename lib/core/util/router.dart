import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/feed/feed_screen.dart';
import 'package:ut_social/profile/profile_info_bloc/profile_info_bloc.dart';
import 'package:ut_social/profile/profile_screen.dart';
import 'package:ut_social/profile/student_repository.dart';

import '../home_screen.dart';

/// Static Namespace for routes
class Routes {
  static const String home = '/';
  static const String feed = 'feed';
  static const String profile = 'profile';
}

/// Correlates routes names to builders
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case Routes.feed:
        return MaterialPageRoute(builder: (_) => FeedScreen());
      case Routes.profile:
        if (args is ProfileArgs) {
          return _profileRoute(args);
        }
        throw Exception('Invalid arguments for ${settings.name}');
        break;
      default:
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _profileRoute(ProfileArgs args) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (BuildContext context) => ProfileInfoBloc(
          args.userId,
          repository: FirebaseStudentRepository(),
        ),
        child: ProfileScreen(isCurrentUser: args.isCurrentUser),
      ),
    );
  }

  static Route<dynamic> _errorRoute(dynamic settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${settings.name}')),
      ),
    );
  }
}

//Arguement Classes

class ProfileArgs {
  final String userId;
  final bool isCurrentUser;

  /// Arguements must not be null, isCurrentUser defaults to false
  const ProfileArgs(this.userId, {this.isCurrentUser = false})
      : assert(userId != null),
        assert(isCurrentUser != null);
}
