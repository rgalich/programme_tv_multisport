import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:meta/meta.dart';

abstract class SportSelectedState extends Equatable {
  const SportSelectedState();

  @override
  List<Object> get props => [];
}

class SportSelectedEmply extends SportSelectedState {}

class SportSelectedLoaded extends SportSelectedState {
  final Sport sport;

  const SportSelectedLoaded({@required this.sport})
      : assert(sport != null);

  @override
  List<Object> get props => [sport];
}

class SportSelectedError extends SportSelectedState {}
