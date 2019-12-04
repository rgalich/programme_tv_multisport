import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/models/models.dart';
import 'package:meta/meta.dart';

abstract class SportDrawerListState extends Equatable {
  const SportDrawerListState();

  @override
  List<Object> get props => [];
}

class SportDrawerListEmply extends SportDrawerListState {}

class SportDrawerListLoading extends SportDrawerListState {}

class SportDrawerListLoaded extends SportDrawerListState {
  final List<SportDrawerList> sportDrawerList;

  const SportDrawerListLoaded({@required this.sportDrawerList})
      : assert(sportDrawerList != null);

  @override
  List<Object> get props => [sportDrawerList];
}

class SportDrawerListError extends SportDrawerListState {}
