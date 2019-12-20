
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

class Sport extends Equatable {
  final String id;
  final String logo;
  final String libelle;
  final int order;
  final DateTime lastUpdate;
  final File logoFile;

  const Sport(
      {this.id,
      this.logo,
      this.libelle,
      this.order,
      this.lastUpdate,
      this.logoFile});

  @override
  List<Object> get props => [id, logo, libelle, lastUpdate, logoFile];

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

  Sport copyWith(
      {String id,
      String logo,
      String libelle,
      int order,
      DateTime lastUpdate,
      File logoFile}) {
    return Sport(
        id: id ?? this.id,
        logo: logo ?? this.logo,
        libelle: libelle ?? this.libelle,
        order: order ?? this.order,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        logoFile: logoFile ?? this.logoFile);
  }
}
