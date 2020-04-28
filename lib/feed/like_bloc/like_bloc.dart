import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  @override
  LikeState get initialState => LikeState();

  LikeBloc();

  @override
  Stream<LikeState> mapEventToState(
    LikeEvent event,
  ) async* {}
}
