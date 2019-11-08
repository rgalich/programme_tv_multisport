import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DateSelectedState extends Equatable {
  const DateSelectedState();

  @override
  List<Object> get props => [];
}

class DateSelectedEmply extends DateSelectedState {}

class DateSelectedLoaded extends DateSelectedState {
  final DateTime date;

  const DateSelectedLoaded({@required this.date})
      : assert(date != null);

  @override
  List<Object> get props => [date];
}

class DateSelectedError extends DateSelectedState {}

