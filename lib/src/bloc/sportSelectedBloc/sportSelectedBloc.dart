import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import 'package:meta/meta.dart';

class SportSelectedBloc extends Bloc<SportSelectedEvent, SportSelectedState> {
  @override
  SportSelectedState get initialState => SportSelectedEmply();

  final SportBloc sportListBloc;
  StreamSubscription sportListSubscription;

  SportSelectedBloc({@required this.sportListBloc}) {
    sportListSubscription = sportListBloc.listen((state) {
      if (state is SportListLoaded) {
        add(SportSelected(sport: state.sportList[0]));
      }
    });
  }

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

  @override
  Future<void> close() {
    sportListSubscription.cancel();
    return super.close();
  }
}
