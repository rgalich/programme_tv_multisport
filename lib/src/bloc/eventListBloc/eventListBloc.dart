import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import './bloc.dart';
import 'package:meta/meta.dart';
import 'package:programme_tv_multisport/src/resources/repository.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  final _repository = Repository();

  final DateSelectedBloc dateSelectedBloc;
  StreamSubscription dateSelectedSubscription;
  final SportBloc sportListBloc;
  StreamSubscription sportListSubscription;
  final SportSelectedBloc sportSelectedBloc;
  StreamSubscription sportSelectedSubscription;
  final ChannelBloc channelListBloc;
  StreamSubscription channelListSubscription;

  EventListBloc(
      {@required this.dateSelectedBloc,
      @required this.sportListBloc,
      @required this.channelListBloc,
      @required this.sportSelectedBloc}) {
    DateTime date;
    List<Sport> sportList;
    List<Channel> channelList;
    Sport sport;

    sportListSubscription = sportListBloc.listen((state) {
      if (state is SportListLoaded) {
        sportList = state.sportList;
        callGetEventList(date, sportList, channelList, sport);
      }
    });

    channelListSubscription = channelListBloc.listen((state) {
      if (state is ChannelListLoaded) {
        channelList = state.channelList;
        callGetEventList(date, sportList, channelList, sport);
      }
    });

    dateSelectedSubscription = dateSelectedBloc.listen((state) {
      if (state is DateSelectedLoaded) {
        date = state.date;
        callGetEventList(date, sportList, channelList, sport);
      }
    });

    sportSelectedSubscription = sportSelectedBloc.listen((state) {
      if (state is SportSelectedLoaded) {
        sport = state.sport;
        callGetEventList(date, sportList, channelList, sport);
      }
    });
  }

  @override
  EventListState get initialState => EventListEmply();

  @override
  Stream<EventListState> mapEventToState(
    EventListEvent event,
  ) async* {
    if (event is GetEventList) {
      yield EventListLoading();
      try {
        final eventList = await _repository.eventList(
            event.date, event.sportList, event.channelList, event.sport);
        yield EventListLoaded(eventList: eventList);
      } catch (_) {
        yield EventListError();
      }
    }
  }

  @override
  Future<void> close() {
    dateSelectedSubscription.cancel();
    sportListSubscription.cancel();
    channelListSubscription.cancel();
    sportSelectedSubscription.cancel();
    return super.close();
  }

  void callGetEventList(DateTime date, List<Sport> sportList,
      List<Channel> channelList, Sport sport) {
    if (date != null && sportList != null && channelList != null) {
      add(GetEventList(
          date: date,
          sportList: sportList,
          channelList: channelList,
          sport: sport));
    }
  }
}
