part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => const <Object>[];
}

class InitializeUser extends UserEvent {}

class LogInUser extends UserEvent {}

class LogOutUser extends UserEvent {}

class UpdateUserProfile extends UserEvent {
  final String firstName;
  final List<Map<String, dynamic>> channels;
  final String lastName;
  final String bio;
  final String avatarUrl;
  final String coverPhotoUrl;
  final String email;
  final int reportCount;
  final bool notificationsEnabled;

  const UpdateUserProfile({
    this.firstName,
    this.channels,
    this.lastName,
    this.bio,
    this.notificationsEnabled,
    this.avatarUrl,
    this.coverPhotoUrl,
    this.email,
    this.reportCount,
  });

  @override
  List<Object> get props => <Object>[
        firstName,
        channels,
        lastName,
        bio,
        notificationsEnabled,
        avatarUrl,
        coverPhotoUrl,
        email,
        reportCount,
      ];
}
