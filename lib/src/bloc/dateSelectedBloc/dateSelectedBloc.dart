import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/resources/repository.dart';
import './bloc.dart';

class DateSelectedBloc extends Bloc<DateSelectedEvent, DateSelectedState> {
  final _repository = Repository();

  @override
  DateSelectedState get initialState => DateSelectedEmply();

  @override
  Stream<DateSelectedState> mapEventToState(
    DateSelectedEvent event,
  ) async* {
    if (event is DateNowSelected) {
      try {
        final date = await _repository.dateNow();
        yield DateSelectedLoaded(date: date);
      } catch(_) {
        yield DateSelectedError();
      }
    }
    if (event is DateSelected) {
      try {
        yield DateSelectedLoaded(date: event.date);
      } catch(_) {
        yield DateSelectedError();
      }
    }
  }
}
