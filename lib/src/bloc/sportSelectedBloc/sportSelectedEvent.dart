import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

abstract class SportSelectedEvent extends Equatable {
  const SportSelectedEvent();

  @override
  List<Object> get props => [];
}

class SportSelected extends SportSelectedEvent {
  final Sport sport;

  const SportSelected({@required this.sport}) : assert(sport != null);

  @override
  List<Object> get props => [sport];
}