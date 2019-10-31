import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SportEvent extends Equatable {
  const SportEvent();

  @override
  List<Object> get props => [];
}

class GetSportList extends SportEvent {}

class SelectSport extends SportEvent {
  final String sportId;

  const SelectSport({@required this.sportId}) : assert(sportId != null);

  @override
  List<Object> get props => [sportId];
}

