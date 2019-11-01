import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';

class SportSelectedBloc extends Bloc<SportSelectedEvent, SportSelectedState> {
  @override
  SportSelectedState get initialState => SportSelectedEmply();

  @override
  Stream<SportSelectedState> mapEventToState(
    SportSelectedEvent event,
  ) async* {
    if (event is SportSelected) {
      try {
          yield SportSelectedLoaded(sport: event.sport);
      } catch (_) {
        yield SportSelectedError();
      }
    }
  }
}
