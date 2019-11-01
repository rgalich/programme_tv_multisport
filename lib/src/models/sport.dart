import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final String id;
  final String logo;
  final String libelle;

  const Sport({this.id, this.logo, this.libelle});

  @override
  List<Object> get props => [id, logo, libelle];

  static Sport fromMap(String id, Map<String, dynamic> map) {
    return Sport(id: id, libelle: map["libelle"], logo: map["logo"]);
  }

  Sport toIsSelected(bool isSelected) {
    return Sport(id: id, logo: logo, libelle: libelle);
  }
}
