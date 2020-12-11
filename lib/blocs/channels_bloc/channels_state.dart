part of 'channels_bloc.dart';

abstract class ChannelsState extends Equatable {
  const ChannelsState();
}

class ChannelsInitial extends ChannelsState {
  @override
  List<Object> get props => [];
}

class ChannelsLoading extends ChannelsState {
  @override
  List<Object> get props => [];
}

class ChannelsLoaded extends ChannelsState {
  @override
  List<Object> get props => [];
}

class ChannelsError extends ChannelsState {
  @override
  List<Object> get props => [];
}
