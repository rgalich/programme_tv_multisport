import 'package:equatable/equatable.dart';

abstract class DateListEvent extends Equatable {
  const DateListEvent();

  @override
  List<Object> get props => [];
}

class GetDateList extends DateListEvent {}
