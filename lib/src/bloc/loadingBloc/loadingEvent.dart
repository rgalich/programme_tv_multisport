import 'package:equatable/equatable.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();

  @override
  List<Object> get props => [];
}

class HideLoading extends LoadingEvent {}

class ShowLoading extends LoadingEvent {}