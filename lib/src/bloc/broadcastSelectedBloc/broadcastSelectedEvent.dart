import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/enums/enums.dart';

abstract class BroadcastSelectedEvent extends Equatable {
  const BroadcastSelectedEvent();

  @override
  List<Object> get props => [];
}

class BroadcastSelected extends BroadcastSelectedEvent {
  final Broadcast broadcast;

  const BroadcastSelected({this.broadcast}) : assert(broadcast != null);

  @override
  List<Object> get props => [broadcast];
}
