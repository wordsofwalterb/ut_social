part of 'profile_info_bloc.dart';

abstract class ProfileInfoEvent extends Equatable {
  const ProfileInfoEvent();
}

/// Load general information about a user. Transitions state to PostLoading
/// and then PostLoaded or PostError.
class LoadProfile extends ProfileInfoEvent {
  const LoadProfile();

  @override
  List<Object> get props => [];
}
