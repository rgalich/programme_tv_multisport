import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final String id;
  final String logo;
  final String libelle;
  final int order;
  final DateTime lastUpdate;

  const Sport({this.id, this.logo, this.libelle, this.order, this.lastUpdate});

  @override
  List<Object> get props => [id, logo, libelle, lastUpdate];

  static Sport fromMap(String id, Map<String, dynamic> map) {
    return Sport(
        id: id,
        libelle: map["libelle"],
        logo: map["logo"],
        order: map["order"],
        lastUpdate: map['lastUpdate'] is Timestamp
            ? map['lastUpdate'].toDate()
            : Timestamp.fromMillisecondsSinceEpoch(map['lastUpdate']).toDate());
  }
}
