import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/enums/enums.dart';

abstract class BroadcastSelectedState extends Equatable {
  const BroadcastSelectedState();

  @override
  List<Object> get props => [];
}

class BroadcastSelectedLoaded extends BroadcastSelectedState {
  final Broadcast broadcast;

  const BroadcastSelectedLoaded({this.broadcast}) : assert(broadcast != null);

  @override
  List<Object> get props => [broadcast];
}

class BroadcastSelectedError extends BroadcastSelectedState {}
