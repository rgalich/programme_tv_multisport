import 'package:equatable/equatable.dart';

class Date extends Equatable {
  final Date date;
  final String libelle;

  const Date({this.date, this.libelle});

  @override
  List<Object> get props => [date, libelle];
}
