import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/add_content/add_post.dart';
import 'package:ut_social/chats/chat_detail_screen.dart';
import 'package:ut_social/core/entities/post.dart';
import 'package:ut_social/core/repositories/comment_repository.dart';
import 'package:ut_social/feed/comment_bloc/comment_bloc.dart';
import 'package:ut_social/feed/comment_screen.dart';
import 'package:ut_social/feed/feed_screen.dart';
import 'package:ut_social/feed/post_bloc/post_bloc.dart';
import 'package:ut_social/login/lost_password_screen.dart';
import 'package:ut_social/profile/edit_profile_screen.dart';
import 'package:ut_social/profile/profile_info_bloc/profile_info_bloc.dart';
import 'package:ut_social/profile/profile_screen.dart';
import 'package:ut_social/profile/student_repository.dart';
import 'package:ut_social/settings/authentication_settings_screen.dart';
import 'package:ut_social/settings/privacy_policy_screen.dart';
import 'package:ut_social/settings/settings_overview_screen.dart';
import 'package:ut_social/settings/terms_of_service_screen.dart';

import '../home_screen.dart';

/// Static Namespace for routes
class Routes {
  static const String home = '/';
  static const String feed = 'feed';
  static const String profile = 'profile';
  static const String editProfile = 'editProfile';
  static const String createPost = 'createPost';
  static const String chatDetail = 'chatDetail';
  static const String postComments = 'postComments';
  static const String termsOfService = 'termsOfService';
  static const String privacyPolicy = 'privacyPolicy';
  static const String authenticationSettings = 'authenticationSettings';
  static const String settingsOverview = 'settingsOverview';
  static const String lostPassword = 'lostPassword';
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
      case Routes.termsOfService:
        return MaterialPageRoute(builder: (_) => TermsOfServiceScreen());
      case Routes.lostPassword:
        return MaterialPageRoute(builder: (_) => LostPasswordScreen());
      case Routes.privacyPolicy:
        return MaterialPageRoute(builder: (_) => PrivacyPolicyScreen());
      case Routes.authenticationSettings:
        return MaterialPageRoute(
            builder: (_) => AuthenticationSettingsScreen());
      case Routes.settingsOverview:
        return MaterialPageRoute(builder: (_) => SettingsOverviewScreen());
      case Routes.postComments:
        if (args is PostCommentsArgs) {
          return _postCommentsRoute(args);
        }
        throw Exception('Invalid arguments for ${settings.name}');
        break;
      case Routes.profile:
        if (args is ProfileArgs) {
          return _profileRoute(args);
        }
        throw Exception('Invalid arguments for ${settings.name}');
        break;
      case Routes.createPost:
        if (args is PostsBloc) {
          return _createPostRoute(args);
        }
        throw Exception('Invalid arguments for ${settings.name}');
        break;
      case Routes.editProfile:
        if (args is ProfileInfoBloc) {
          return _editProfileRoute(args);
        }
        throw Exception('Invalid arguments for ${settings.name}');
        break;
      case Routes.chatDetail:
        return MaterialPageRoute(
          builder: (_) => ChatDetailScreen(),
        );
      default:
        return _errorRoute(settings);
    }
  }

// Moved route generation to this section for brevity in previous section

  static Route<dynamic> _postCommentsRoute(PostCommentsArgs args) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<CommentsBloc>(
        create: (context) => CommentsBloc(
          args.post.id,
          commentRepository: FirebaseCommentsRepository(),
        ),
        child: BlocProvider.value(
          value: args.postsBloc,
          child: CommentScreen(args.post),
        ),
      ),
    );
  }

  static Route<dynamic> _createPostRoute(PostsBloc bloc) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: CreatePostScreen(),
      ),
    );
  }

  static Route<dynamic> _editProfileRoute(ProfileInfoBloc bloc) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: bloc,
        child: EditProfileScreen(),
      ),
    );
  }

  static Route<dynamic> _profileRoute(ProfileArgs args) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (BuildContext context) => ProfileInfoBloc(
          args.userId,
          repository: FirebaseStudentRepository(),
        )..add(const LoadProfile()),
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

class PostCommentsArgs {
  final PostsBloc postsBloc;
  final Post post;

  const PostCommentsArgs(this.postsBloc, this.post);
}
