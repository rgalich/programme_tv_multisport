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
        final dateList = await _repository.dateList();
        yield DateListLoaded(dateList: dateList);
      } catch(_) {
        yield DateListError();
      }
    }
  }
}
