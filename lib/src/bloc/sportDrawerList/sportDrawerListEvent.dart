import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:meta/meta.dart';

abstract class SportDrawerListEvent extends Equatable {
  const SportDrawerListEvent();

  @override
  List<Object> get props => [];
}

class GetSportDrawerList extends SportDrawerListEvent {
  final List<Sport> sportList;

  const GetSportDrawerList({@required this.sportList})
      : assert(sportList != null);

  @override
  List<Object> get props => [sportList];
}
