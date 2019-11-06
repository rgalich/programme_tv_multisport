import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DateListState extends Equatable {
  const DateListState();

  @override
  List<Object> get props => [];
}

class DateListEmply extends DateListState {}

class DateListLoading extends DateListState {}

class DateListLoaded extends DateListState {
  final List<DateTime> dateList;

  const DateListLoaded({@required this.dateList})
      : assert(dateList != null);

  @override
  List<Object> get props => [dateList];
}

class DateListError extends DateListState {}
