import 'package:equatable/equatable.dart';

abstract class SportEvent extends Equatable {
  const SportEvent();

  @override
  List<Object> get props => [];
}

class GetSportList extends SportEvent {}
