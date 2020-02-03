import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/enums/enums.dart';
import './bloc.dart';

class BroadcastSelectedBloc extends Bloc<BroadcastSelectedEvent, BroadcastSelectedState> {
  @override
  BroadcastSelectedState get initialState => BroadcastSelectedLoaded(broadcast: Broadcast.Live);

  @override
  Stream<BroadcastSelectedState> mapEventToState(
    BroadcastSelectedEvent event,
  ) async* {
    if (event is BroadcastSelected) {
      try {
        yield BroadcastSelectedLoaded(broadcast: event.broadcast);
      } catch(_) {
        yield BroadcastSelectedError();
      }
    }
  }
}
