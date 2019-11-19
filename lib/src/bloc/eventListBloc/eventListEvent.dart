import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

abstract class EventListEvent extends Equatable {
  const EventListEvent();

  @override
  List<Object> get props => [];
}

class GetEventList extends EventListEvent {
  final DateTime date;
  final List<Sport> sportList;
  final List<Channel> channelList;

  const GetEventList({@required this.date, @required this.sportList, @required this.channelList}) : assert(date != null && sportList != null && channelList != null);

  @override
  List<Object> get props => [date, sportList, channelList];
}
