import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  @override
  MessagesState get initialState => MessagesInitial();

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
