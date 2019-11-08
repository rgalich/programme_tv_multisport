import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DateSelectedEvent extends Equatable {
  const DateSelectedEvent();

  @override
  List<Object> get props => [];
}

class DateSelected extends DateSelectedEvent {
  final DateTime date;

  const DateSelected({@required this.date}) : assert(date != null);

  @override
  List<Object> get props => [date];
}

class DateNowSelected extends DateSelectedEvent {}