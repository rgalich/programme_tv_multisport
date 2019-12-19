import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String id;
  final String pictureName;
  final String libelle;
  final File pictureFile;
  final DateTime lastUpdate;

  const Channel(
      {this.id,
      this.pictureName,
      this.libelle,
      this.pictureFile,
      this.lastUpdate});

  @override
  List<Object> get props => [id, pictureName, libelle, pictureFile];

  static Channel fromMap(String id, Map<String, dynamic> map) {
    return Channel(
        id: id,
        libelle: map["libelle"],
        pictureName: map["pictureName"],
        lastUpdate: map['lastUpdate'] is Timestamp
            ? map['lastUpdate'].toDate()
            : Timestamp.fromMillisecondsSinceEpoch(map['lastUpdate']).toDate());
  }

  Channel copyWith(
      {String id, String pictureName, String libelle, File pictureFile, DateTime lastUpdate}) {
    return Channel(
        id: id ?? this.id,
        pictureName: pictureName ?? this.pictureName,
        libelle: libelle ?? this.libelle,
        pictureFile: pictureFile ?? this.pictureFile,
        lastUpdate: lastUpdate ?? this.lastUpdate);
  }
}
