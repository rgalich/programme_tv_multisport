import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/resources/repository.dart';
import './bloc.dart';

class DateListBloc extends Bloc<DateListEvent, DateListState> {
  final _repository = Repository();

  @override
  DateListState get initialState => DateListEmply();

  @override
  Stream<DateListState> mapEventToState(
    DateListEvent event,
  ) async* {
    if (event is GetDateList) {
      yield DateListLoading();
      try {
        final dateNow = (await _repository.dateNow());
        List<DateTime> dateList = new List<DateTime>();
        dateList.add(dateNow);

        for (var i = 1; i <= 7; i++) {
          dateList.add(dateNow.add(new Duration(days: i)));
          dateList.add(dateNow.add(new Duration(days: i * -1)));
        }
        dateList.sort((a, b) => a.compareTo(b));
        yield DateListLoaded(dateList: dateList);
      } catch(_) {
        yield DateListError();
      }
    }
  }
}
