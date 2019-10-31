import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final String id;
  final String logo;
  final String libelle;
  final bool isSelected;

  const Sport({this.id, this.logo, this.libelle, this.isSelected});

  @override
  List<Object> get props => [id, logo, libelle, isSelected];

  static Sport fromMap(String id, Map<String, dynamic> map) {
    return Sport(id: id, libelle: map["libelle"], logo: map["logo"], isSelected: false);
  }

  Sport toIsSelected(bool isSelected) {
    return Sport(id: id, logo: logo, libelle: libelle, isSelected: isSelected);
  }
}
