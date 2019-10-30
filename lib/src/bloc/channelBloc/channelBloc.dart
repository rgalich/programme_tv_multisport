import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:programme_tv_multisport/src/resources/repository.dart';
import './bloc.dart';

class ChannelBloc extends Bloc<ChannelEvent, ChannelState> {
  final _repository = Repository();

  @override
  ChannelState get initialState => ChannelListEmply();

  @override
  Stream<ChannelState> mapEventToState(
    ChannelEvent event,
  ) async* {
    if (event is GetChannelList) {
      yield ChannelListLoading();
      try {
        final channelList = await _repository.channelList();
        yield ChannelListLoaded(channelList: channelList);
      } catch(_) {
        yield ChannelListError();
      }
    }
  }
}
