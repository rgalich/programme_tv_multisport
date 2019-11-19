import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

abstract class EventListState extends Equatable {
  const EventListState();

  @override
  List<Object> get props => [];
}

class EventListEmply extends EventListState {}

class EventListLoading extends EventListState {}

class EventListLoaded extends EventListState {
  final List<Event> eventList;

  const EventListLoaded({@required this.eventList})
      : assert(eventList != null);

  @override
  List<Object> get props => [eventList];
}

class EventListError extends EventListState {}
