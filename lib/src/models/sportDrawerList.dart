import 'package:equatable/equatable.dart';
import 'package:programme_tv_multisport/src/models/models.dart';

class SportDrawerList extends Equatable {
  final List<Sport> sportList;
  final String libelle;

  const SportDrawerList({this.sportList, this.libelle});

  @override
  List<Object> get props => [sportList, libelle];
}
