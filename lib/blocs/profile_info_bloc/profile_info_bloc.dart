import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/failure.dart';
import 'package:ut_social/models/student.dart';
import 'package:ut_social/services/student_repository.dart';

part 'profile_info_event.dart';
part 'profile_info_state.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {
  final String _userId;

  final StudentRepository _repository;

  ProfileInfoBloc(String userId, {@required StudentRepository repository})
      : assert(userId != null),
        assert(repository != null),
        _userId = userId,
        _repository = repository,
        super(const ProfileInfoInitial());

  @override
  Stream<ProfileInfoState> mapEventToState(
    ProfileInfoEvent event,
  ) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    }
  }

  Stream<ProfileInfoState> _mapLoadProfileToState() async* {
    final studentResult = await _repository.getStudentById(_userId);
    if (studentResult.hasError) {
      yield ProfileInfoFailure(studentResult.error);
    } else {
      yield ProfileInfoLoaded(studentResult.student);
    }
  }
}
