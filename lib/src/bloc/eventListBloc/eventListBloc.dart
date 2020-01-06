import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/enums/broadcast.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import './bloc.dart';
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
  final BroadcastSelectedBloc broadcastSelectedBloc;
  StreamSubscription broadcastSelectedSubscription;

  EventListBloc(
      {@required this.dateSelectedBloc,
      @required this.sportListBloc,
      @required this.channelListBloc,
      @required this.sportSelectedBloc,
      @required this.broadcastSelectedBloc}) {
    DateTime date;
    List<Sport> sportList;
    List<Channel> channelList;
    Sport sport;
    Broadcast broadcast;

    sportListSubscription = sportListBloc.listen((state) {
      if (state is SportListLoaded) {
        sportList = state.sportList;
        callGetEventList(date, sportList, channelList, sport, broadcast);
      }
    });

    channelListSubscription = channelListBloc.listen((state) {
      if (state is ChannelListLoaded) {
        channelList = state.channelList;
        callGetEventList(date, sportList, channelList, sport, broadcast);
      }
    });

    dateSelectedSubscription = dateSelectedBloc.listen((state) {
      if (state is DateSelectedLoaded) {
        date = state.date;
        callGetEventList(date, sportList, channelList, sport, broadcast);
      }
    });

    sportSelectedSubscription = sportSelectedBloc.listen((state) {
      if (state is SportSelectedLoaded) {
        sport = state.sport;
        callGetEventList(date, sportList, channelList, sport, broadcast);
      }
    });

    broadcastSelectedSubscription = broadcastSelectedBloc.listen((state) {
      if (state is BroadcastSelectedLoaded) {
        broadcast = state.broadcast;
        callGetEventList(date, sportList, channelList, sport, broadcast);
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
            event.date, event.sportList, event.channelList, event.sport, event.broadcast);
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
    broadcastSelectedSubscription.cancel();
    return super.close();
  }

  void callGetEventList(DateTime date, List<Sport> sportList,
      List<Channel> channelList, Sport sport, Broadcast broadcast) {
    if (date != null && sportList != null && channelList != null && sport != null) {
      add(GetEventList(
          date: date,
          sportList: sportList,
          channelList: channelList,
          sport: sport,
          broadcast: broadcast));
    }
  }
}
