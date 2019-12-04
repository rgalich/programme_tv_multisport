import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final String id;
  final String logo;
  final String libelle;
  final int order;

  const Sport({this.id, this.logo, this.libelle, this.order});

  @override
  List<Object> get props => [id, logo, libelle];

  static Sport fromMap(String id, Map<String, dynamic> map) {
    return Sport(id: id, libelle: map["libelle"], logo: map["logo"], order: map["order"]);
  }
}
