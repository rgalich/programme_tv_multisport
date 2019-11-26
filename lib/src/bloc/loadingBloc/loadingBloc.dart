import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/bloc/bloc.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  final EventListBloc eventListBloc;
  StreamSubscription eventListSubscription;

  LoadingBloc({@required this.eventListBloc}) {
    eventListSubscription = eventListBloc.listen((state) {
      if (state is EventListLoading) {
        add(ShowLoading());
      }
      if (state is EventListLoaded) {
        add(HideLoading());
      }
    });
  }

  @override
  LoadingState get initialState => LoadingEmply();

  @override
  Stream<LoadingState> mapEventToState(
    LoadingEvent event,
  ) async* {
    if (event is ShowLoading) {
      yield LoadingVisible();
    } else {
      yield LoadingHidden();
    }
  }

    @override
  Future<void> close() {
    eventListSubscription.cancel();
    return super.close();
  }
}
