part of 'profile_info_bloc.dart';

abstract class ProfileInfoState extends Equatable {
  const ProfileInfoState();

  @override
  List<Object> get props => [];
}

class ProfileInfoInitial extends ProfileInfoState {
  const ProfileInfoInitial();
}

class ProfileInfoLoading extends ProfileInfoState {
  const ProfileInfoLoading();
}

class ProfileInfoLoaded extends ProfileInfoState {
  final Student student;

  const ProfileInfoLoaded(this.student) : assert(student != null);
}

class ProfileInfoFailure extends ProfileInfoState {
  final Failure failure;

  const ProfileInfoFailure(this.failure) : assert(failure != null);
}
