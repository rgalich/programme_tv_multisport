import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/resources/repository.dart';
import './bloc.dart';

class SportBloc extends Bloc<SportEvent, SportState> {
  final _repository = Repository();

  @override
  SportState get initialState => SportListEmply();

  @override
  Stream<SportState> mapEventToState(
    SportEvent event,
  ) async* {
    if (event is GetSportList) {
      yield SportListLoading();
      try {
        final sportList = await _repository.sportList();
        yield SportListLoaded(sportList: sportList);
      } catch(_) {
        yield SportListError();
      }
    }
  }
}
