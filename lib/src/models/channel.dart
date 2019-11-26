import 'dart:io';
import 'package:equatable/equatable.dart';

class Channel extends Equatable {
  final String id;
  final String pictureName;
  final String libelle;
  final File pictureFile;

  const Channel({this.id, this.pictureName, this.libelle, this.pictureFile});

  @override
  List<Object> get props => [id, pictureName, libelle, pictureFile];

  static Channel fromMap(String id, Map<String, dynamic> map) {
    return Channel(id: id, libelle: map["libelle"], pictureName: map["fileName"]);
  }

  Channel copyWith({String id, String pictureName, String libelle, File pictureFile}) {
    return Channel(id: id ?? this.id, pictureName: pictureName ?? this.pictureName, libelle: libelle ?? this.libelle, pictureFile: pictureFile ?? this.pictureFile);
  }
}
