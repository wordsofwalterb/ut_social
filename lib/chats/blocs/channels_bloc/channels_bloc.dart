import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'channels_event.dart';
part 'channels_state.dart';

class ChannelsBloc extends Bloc<ChannelsEvent, ChannelsState> {
  @override
  ChannelsState get initialState => ChannelsInitial();

  @override
  Stream<ChannelsState> mapEventToState(
    ChannelsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
