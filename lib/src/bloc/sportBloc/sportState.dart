import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

abstract class SportState extends Equatable {
  const SportState();

  @override
  List<Object> get props => [];
}

class SportListEmply extends SportState {}

class SportListLoading extends SportState {}

class SportListLoaded extends SportState {
  final List<Sport> sportList;

  const SportListLoaded({@required this.sportList})
      : assert(sportList != null);

  @override
  List<Object> get props => [sportList];
}

class SportListError extends SportState {}