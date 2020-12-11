part of 'messages_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();
}

class MessagesInitial extends MessagesState {
  @override
  List<Object> get props => [];
}
