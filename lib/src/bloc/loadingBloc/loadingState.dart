import 'package:equatable/equatable.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadingEmply extends LoadingState {}

class LoadingHidden extends LoadingState {}

class LoadingVisible extends LoadingState {}
