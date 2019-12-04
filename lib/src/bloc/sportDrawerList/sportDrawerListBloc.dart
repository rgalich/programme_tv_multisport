import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class SportDrawerListBloc extends Bloc<SportDrawerListEvent, SportDrawerListState> {
  final SportBloc sportListBloc;
  StreamSubscription sportListSubscription;

  SportDrawerListBloc({@required this.sportListBloc}) {
    sportListSubscription = sportListBloc.listen((state) {
      if (state is SportListLoaded) {
        add(GetSportDrawerList(sportList: state.sportList));
      }
    });
  }

  @override
  SportDrawerListState get initialState => SportDrawerListEmply();

  @override
  Stream<SportDrawerListState> mapEventToState(
    SportDrawerListEvent event,
  ) async* {
    if (event is GetSportDrawerList) {
      yield SportDrawerListLoading();
      try {
        final List<SportDrawerList> sportDrawerList = new List<SportDrawerList>();
        sportDrawerList.add(new SportDrawerList(
          libelle: 'SPORTS POPULAIRES',
          sportList: event.sportList.where((sport) => sport.order == null).toList()
        ));

        sportDrawerList.add(new SportDrawerList(
          libelle: 'AUTRES SPORTES [A-Z]',
          sportList: event.sportList.where((sport) => sport.order == null).toList()
        ));
          
        yield SportDrawerListLoaded(sportDrawerList: sportDrawerList);
      } catch (_) {
        yield SportDrawerListError();
      }
    }
  }

  @override
  Future<void> close() {
    sportListSubscription.cancel();
    return super.close();
  }
}
