import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:meta/meta.dart';

abstract class ChannelState extends Equatable {
  const ChannelState();

  @override
  List<Object> get props => [];
}

class ChannelListEmply extends ChannelState {}

class ChannelListLoading extends ChannelState {}

class ChannelListLoaded extends ChannelState {
  final List<Channel> channelList;

  const ChannelListLoaded({@required this.channelList})
      : assert(channelList != null);

  @override
  List<Object> get props => [channelList];
}

class ChannelListError extends ChannelState {}